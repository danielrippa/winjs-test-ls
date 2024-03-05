
  do ->

    { new-test-suite } = dependency 'test.TestSuite'

    { scenario, should, expect } = new-test-suite!

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

          should -> expect (-> NativeType <[ Number ]> 'a') .to-throw "Value ('a') is not a Number"

          should -> expect (-> Either <[ Number String ]> 1) .to-return 1

          should -> expect (-> Either <[ Number String Boolean ]> 1) .to-return 1
          should -> expect (-> Either <[ Number String Boolean ]> 'a') .to-return 'a'
          should -> expect (-> Either <[ Number String Boolean ]> true) .to-return true

          should -> expect (-> Either <[ String Boolean ]> 1) .to-throw 'Value (1) is not a String or a Boolean'