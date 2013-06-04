describe 'JasmineSetup', ->
    it 'attaches webdriver helpers to each spec when it is executed', ->
        expect(typeof @getDeferred).toBe("function")
        expect(typeof @waitForElement).toBe("function")
        expect(typeof @waitForVisible).toBe("function")
        expect(typeof @waitForNotVisible).toBe("function")
        expect(typeof @findElement).toBe("function")
        expect(typeof @isElementPresent).toBe("function")
        expect(typeof @click).toBe("function")
        expect(typeof @mouseOver).toBe("function")
        expect(typeof @sendKeys).toBe("function")

    it 'defines a "driver" globally and attaches it to each spec', ->
        expect(window.driver).not.toBeUndefined()
        expect(@driver).toEqual window.driver

    it 'waits for webdriver promises to be fulfilled', ->
        done = false
        promise = webdriver.promise.Application.getInstance().scheduleWait 'wait for done to be true', =>
            done
        , 1000, 'promise not fulfilled'

        window.setTimeout =>
            done = true
        , 200

        promise

    xit 'fails the test when a webdriver promise is not fulfilled within the allowed time', ->
        # This is a test that is expected to fail.
        # TODO Figure out how to write it so it succeeds

        promise = webdriver.promise.Application.getInstance().scheduleWait 'wait for done to be true', =>
            false
        , 10000, 'promise not fulfilled'

    xit 'fails the test when a webdriver promise fails', ->
        # This is a test that is expected to fail.
        # TODO Figure out how to write it so it succeeds

        promise = webdriver.promise.Application.getInstance().scheduleWait 'wait for done to be true', =>
            false
        , 200, 'promise not fulfilled'

