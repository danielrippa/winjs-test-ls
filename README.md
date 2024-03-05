# A BDD/TDD testing framework for ([danielrippa/winjs](https://github.com/danielrippa/winjs) and [danielrippa/winjs64](https://github.com/danielrippa/winjs64)).

## Features:

* **English-like Assertions**: the framework's assertion methods are designed to enable you to write scenarios in **natural language**,
  enhancing readability and facilitating collaboration between technical and non-technical stake-holders.
* **Variety of assertions**: The framework provides various assertion methods like `equals`, `to-be-a`, `to-throw`, `to-return` for verifying different aspects of your code.
* **Test Results**: Each assertion returns a test result object containing a boolean flag indicating success and a message describing the outcome.
* **Test Suites**: Organize tests into logical groups using the `new-test-suite` function.
* **Scenarios**: Define individual tests within a suite using the `scenario` function, providing a description and the test logic. This structure can be used for both TDD-style tests and user stories in BDD.
* **Nested Scenarios**: Organize tests hierarchically within suites for better structure and clarity.
* **Test Suite Statistics**: Track and report overall test suite performance, including the number of passed and failed tests, along with their percentages.

## Example

```livescript  
scenario "namespace 'native'" ->

    scenario 'Type' ->

      type = dependency 'native.Type'

      { NativeType, Either, Maybe } = type

      scenario 'NativeType/Either' ->

        should -> expect (-> NativeType <[ Number ]> 10) .to-return 10
        should -> expect (-> NativeType <[ String ]> 'a') .to-return 'a'
        should -> expect (-> NativeType <[ Boolean ]> true) .to-return true
        should -> expect (-> NativeType <[ Function ]> ->) .to-return ->
        should -> expect (-> NativeType <[ Array ]> []) .to-return []
```

[](examples/test-suite-example.jpg)!
