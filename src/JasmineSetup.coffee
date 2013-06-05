originalItFunction = window.it

window.it = (description, test) ->
    originalItFunction description, ->
        promiseFulfilledSemaphore = jasmine.createSpy 'promise fulfilled'
        testResult = test.call @

        if testResult?.then? # Checking for a promise object
            testResult.then =>
                promiseFulfilledSemaphore()
            , (msg) =>
                @fail msg
                promiseFulfilledSemaphore()

            waitsFor ->
                promiseFulfilledSemaphore.wasCalled
            , 'Webdriver promise to be resolved', 5000


beforeEach ->
    _.extend @, WebdriverHelper
    @driver = window.driver = window.driver or new webdriver.Builder().build()
