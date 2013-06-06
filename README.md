jasmine-webdriver-controller
============================
Adds methods to jasmine that enable it to send commands to a webdriver server. This allows for component oriented
testing from jasmine.

Overview
--------
- Specs that return a promise are wrapped in a timeout detector. If the promise isn't resolved in 5 seconds or the
  promise fails, the test will fail. A spec must return a webdriver promise for this functionality to work.
- A collection of helper methods are attached to each spec.
- A global `Driver` object is created to communicate with the webdriver server.

Selectors
---------
The documentation for the selector factories in WebdriverJS is poor. Here's an example:

By.id("user")

I think you can also pass strings and DOM element pointers as selectors, but I'm not clear on how/if this works.

Helper Methods
--------------
All of the available methods are added to the `this` object for each spec. They can be accessed from within a jasmine
test as `this.method-name()`.

### getDeferred()
getDeferred() => *webdriver.promise.Deferred*

A convenience factory for WebdriverJS `Deferred` objects. These objects contain a promise and the methods to resolve
the promise.

See <https://code.google.com/p/selenium/wiki/WebDriverJs#Deferred_Objects> for a complete explaination of `Deferred`.

### waitForElement(selector)
waitForElement(selector) => *webdriver.promise.Promise*

Waits until the element selected by the `selector` exists in the DOM.

#### parameters:
- selector -- a valid Webdriver selector

### waitForVisible(selector)
waitForVisible(selector) => *webdriver.promise.Promise*

Waits until the element selected by the `selector` is visible in the DOM. For an element to be visible, all of the
following must be true:

-   It exists in the DOM
-   It does not have the CSS `visibility: hidden` applied to it
-   It does not have the CSS `display: none` applied to it
-   It has a non-zero height and width

#### parameters:
- selector -- a valid Webdriver selector

### waitForNotVisible(selector)
waitForNotVisible(selector) => *webdriver.promise.Promise*

Waits until the element selected by the `selector` is not visible in the DOM. For an element to not be visible, at least
one of the following must be true:

-   It does not exist in the DOM
-   It has the CSS `visibility: hidden` applied to it
-   It has the CSS `display: none` applied to it
-   It has a zero height or width

#### parameters:
- selector -- a valid Webdriver selector

### click(selector)
click(selector) => *webdriver.promise.Promise*

Clicks the element selected by the `selector`.

#### parameters:
- selector -- a valid Webdriver selector

### mouseOver(selector)
mouseOver(selector) => *webdriver.promise.Promise*

Hovers the mouse cursor over the element selected by the `selector`.

#### parameters:
- selector -- a valid Webdriver selector

### sendKeys(selector, keys)
sendKeys(selector, keys) => *webdriver.promise.Promise*

Gives focus to the element selected by the `selector`, then sends keystrokes.

#### parameters
- **selector**

  a valid Webdriver selector
- **keys**

  a string of keys to be sent

TODO
----
- Expose the webdriver selector factories (because it is so hard to find documentation for them).
- Figure out whether findElement() and isElementPresent() should be part of this API.
- Figure out to make the 'failing test' specs not fail the tests.
