beforeEach ->
    __jasmineWaitsFor__ ->
        callback.called
    , 'loading dependencies', 8000

    __jasmineRuns__ ->

    # Part of local storage/data source mocking.
    localStorage.clear()

    unless resultSummaryHidden
        resultSummaryHidden = true
        Ext.query('.results .summary')[0].style.display = 'none'

    if useWebdriver
        # Attaches to the server and session controlling this browser.
        @driver = window.driver = window.driver or new webdriver.Builder().build()

        # Enables helper functions (as in WebDriverElementsHelper.coffee) to create and return Promises.
        @getDeferred = ->
            new webdriver.promise.Deferred()

    # Adds the "testDiv" div to the test page, so that each test has a clean sandbox in which to play.
    Ext.DomHelper.append Ext.getBody(), '<div style="clear:both;">&nbsp;</div><div id="testDiv" style="margin-left: 20px;position: relative;"/>'

    # Set up a mock Rally environment.  Fixes: "Uncaught TypeError: Cannot call method 'getWorkspace' of null"
    # Requires: rui-mock files.
    Ext.create('Rally.test.mock.env.Global').setup @


    # Gives each spec access to the augmented "once" method (with default timeout, etc.)
    @once = window.once

    # Adds the helper methods defined in WebDriverElementsHelper to each spec.
    Helpers.WebDriverElementsHelper.augmentSpec @

afterEach ->
    if !ignoringSloppyTests && Ext.ComponentQuery.query('*').length > @countOfExtComponentsBefore
        @fail "not all Ext components cleaned up: #{Ext.Array.pluck(Ext.ComponentQuery.query('*').splice(@countOfExtComponentsBefore),
            'componentCls').join(', ')}"

    # Part of local storage/data source mocking.
    try Rally.state.SessionStorage.getInstance()._removeAllSessionState()
    catch e

    Ext.fx.Manager.items.each (anim) ->
        anim.end()

    Deft.Injector.reset()
    sinonSandboxTearDown @
    cleanUpDomBody()
