describe 'JasmineSetup', ->
    it 'attaches webdriver helpers to each spec when it is executed', ->
        expect(@waitForElement).not.toBeUndefined()