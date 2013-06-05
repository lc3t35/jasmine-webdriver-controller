describe 'WebdriverHelper', ->

    it 'provides webdriver defered objects', ->
        deferred = @getDeferred()

        expect(deferred).not.toBeUndefined()
        expect(deferred.promise).not.toBeUndefined()
        expect(deferred.reject).not.toBeUndefined()
        expect(deferred.resolve).not.toBeUndefined()
        expect(typeof deferred.isPending).toBe 'function'

    it 'waits for an element to exist when waitForElement() is called', ->
        promise = @waitForElement webdriver.By.id 'testDiv'
        promise.then ->
            $('#testDiv').remove()

        $('<div id="testDiv"></div>').appendTo 'body'

        promise

    it 'waits for an element to be visble when waitForVisible() is called', ->
        testDiv = $('<div id="testDiv" style="display: none; width: 10px; height: 10px;"></div>').appendTo 'body'

        promise = @waitForVisible webdriver.By.id 'testDiv'
        promise.then ->
            testDiv.remove()

        testDiv.show()

        promise

    it 'waits for an element to be hidden when waitForNotVisible() is called', ->
        testDiv = $('<div id="testDiv" style="width: 10px; height: 10px;"></div>').appendTo 'body'

        promise = @waitForNotVisible webdriver.By.id 'testDiv'
        promise.then ->
            testDiv.remove()

        testDiv.hide()

        promise

    xit 'What is the use case for the findElement() method?', ->
    xit 'What is the use case for the isElementPresent() method?', ->

    it 'clicks an element when click() is called', ->
        clickHandler = jasmine.createSpy 'elementWasClick'
        testDiv = $('<div id="testDiv" style="width: 10px; height: 10px;"></div>').appendTo 'body'
        testDiv.click(clickHandler)

        promise = @click webdriver.By.id 'testDiv'
        promise.then ->
            expect(clickHandler).toHaveBeenCalled()
            testDiv.remove()

    it 'hovers the mouse over an element when mouseOver() is called', ->
        hoverHandler = jasmine.createSpy 'elementWasHovered'
        testDiv = $('<div id="testDiv" style="width: 10px; height: 10px;"></div>').appendTo 'body'
        testDiv.mouseenter(hoverHandler)

        promise = @mouseOver webdriver.By.id 'testDiv'
        promise.then ->
            expect(hoverHandler).toHaveBeenCalled()
            testDiv.remove()

    it 'sends keystrokes when sendKeys() is called', ->
        testField = $('<input id="testField" type="text" name="testField" value=""/>').appendTo 'body'

        promise = @sendKeys webdriver.By.id('testField'), 'Man of Steel'
        promise.then ->
            expect(testField.val()).toBe 'Man of Steel'
            testField.remove()

