describe 'WebdriverHelper', ->

    it 'provides webdriver defered objects', ->
        deferred = @getDeferred()

        expect(deferred).not.toBeUndefined()
        expect(deferred.promise).not.toBeUndefined()
        expect(deferred.reject).not.toBeUndefined()
        expect(deferred.resolve).not.toBeUndefined()
        expect(typeof deferred.isPending).toBe 'function'

    it 'waits for an element to exist', ->
        promise = @waitForElement webdriver.By.id 'testDiv'
        promise.then ->
            $('#testDiv').remove()

        $('body').append _.template '<div id="testDiv"></div>'

        promise
