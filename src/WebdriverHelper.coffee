window.WebdriverHelper =
    getDeferred: ->
        new webdriver.promise.Deferred()

    waitFor: (opts) ->
        unless opts.timeout?
            opts.timeout = 7000

        unless opts.condition?
            throw new Error('Condition attribute not specified')

        webdriver.promise.Application.getInstance().scheduleWait opts.description, opts.condition, opts.timeout, opts.message

    waitForElement: (selector) ->
        selector.doNotReject = true
        new webdriver.WebElement(
            driver,
            @waitFor(
                condition: => @isElementPresent(selector)
                description: 'element to be present'
            ).then =>
                @waitFor(
                    condition: =>
                        @findElement(selector)
                    description: "Waiting for element matching #{@_selectorToString(selector)} to be in the DOM"
                )
        )

    waitForVisible: (selector) ->
        selector.doNotReject = true
        new webdriver.WebElement(
            driver,
            @waitFor(
                condition: =>
                    @findElement(selector).then (el) ->
                        el?.isDisplayed().then (displayed) ->
                            el if displayed
                        , (msg) => false
                description: "Waiting for element matching #{@_selectorToString(selector)} to be visible"
            )
        )

    ## @return {webdriver.promise.Promise} that resolves to null
    waitForNotVisible: (selector) ->
        deferred = @getDeferred()
        @waitFor(
            condition: =>
                @findElement(selector).then (el) ->
                    el.isDisplayed().then (displayed) =>
                        !displayed
                    , (msg) =>
                        if msg.name is 'StaleElementReferenceError'
                            deferred.resolve null
                        else
                            deferred.reject msg
                , (msg) =>
                    if msg.name is 'NoSuchElementError'
                        deferred.resolve null
                    else
                        deferred.reject msg
            description: "Waiting for element matching #{@_selectorToString(selector)} to not be visible"
        ).then =>
            deferred.resolve null
        , (msg) => deferred.reject msg if deferred.isPending()

        deferred.promise

    findElement: (selector) ->
        if selector.text? and !@_isElement(selector)
            new webdriver.WebElement(
                driver,
                driver.findElements(selector).then (els) =>
                    getTextArray = ([el, el.getText()] for el in els)
                    webdriver.promise.fullyResolved(getTextArray).then (resolvedTextArray) =>
                        for [el, elText] in resolvedTextArray
                            if elText.indexOf(selector.text) > -1
                                return el
                        @_rejectOrNull(selector)
            )
        else
            deferred = @getDeferred()
            driver.findElement(selector).then (el) ->
                deferred.resolve el
            , (msg) ->
                if selector.doNotReject
                    deferred.resolve {}
                else
                    deferred.reject msg

            new webdriver.WebElement(
                driver,
                deferred.promise
            )

    isElementPresent: (selector) ->
        if selector.text?
            driver.findElements(selector).then (els) ->
                getTextArray = ([el, el.getText()] for el in els)
                webdriver.promise.fullyResolved(getTextArray).then (resolvedTextArray) ->
                    for [el, elText] in resolvedTextArray
                        if elText.indexOf(selector.text) > -1
                            return true
                return false
        else
            driver.isElementPresent(selector)

    click: (selector) ->
        new webdriver.WebElement(
            driver,
            @waitForVisible(selector).then (el) -> el.click().then -> el
        )

    mouseOver: (selector) ->
        new webdriver.WebElement(
            driver,
            @findElement(selector).then (el) ->
                driver.actions().mouseMove(el).perform().then -> el
        )

    sendKeys: (selector, keys) ->
        new webdriver.WebElement(
            driver,
            @findElement(selector).then (el) ->
                el.sendKeys keys
                el
        )

    _rejectOrNull: (selector) ->
        if selector.doNotReject
            return {}
        else
            webdriver.promise.rejected {
                name: "NoSuchElementError"
                message: "Unable to find element matching #{@_selectorToString(selector)}"
            }
    _isElement: (obj) ->
        obj.nodeName?

    _selectorToString: (selector) ->
        s = selector
        s = selector.dom if selector.dom?
        if @_isElement(s)
            "#{s.nodeName}: id=#{s.id}, class=#{s.className}"
        else
            JSON.stringify(s)

