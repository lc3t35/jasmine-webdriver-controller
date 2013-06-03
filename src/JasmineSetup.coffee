
beforeEach ->
    console.log 'executing global beforeEach()'

    for name, method of WebdriverHelper
        @[name] = method

afterEach ->
    console.log 'executing global afterEach()'