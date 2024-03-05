
  do ->

    { stringify } = dependency 'prelude.Type'

    test-result = (success, message) -> { message, success }

    succeed = (message) -> test-result yes, message
    fail    = (message) -> test-result no,  message

    #

    stringified = -> "( #{ stringify it } )"

    #

    equals = (one, another) ->

      message = "Expected #{ stringified one } to be equal to #{ stringified another }"

      if one is another
        succeed message
      else
        fail message

    must-be-a = (value, type-name) ->

      actual-type-name = native-type-name value

      message = "Expected #{ stringified value } to be a '#type-name'"

      if actual-type-name is type-name
        succeed message
      else
        fail "#message, but it is a '#actual-type-name'"

    throws = (fn, required-message) ->

      message = "Expected function #{ stringified fn } to throw '#required-message'"

      try fn! ; return fail "#message, but it didn't throw any error"
      catch e

        if e.message is required-message
          succeed message
        else
          fail "#message, but it threw '#{ e.message }'"

    returns = (fn, expected-value) ->

      message = "Expected function #{ stringified fn } to return #{ stringified expected-value }"

      try actual-value = fn!
      catch e => return fail "#message, but it threw '#{ e.message }'"

      if (stringified actual-value) is (stringified expected-value)
        succeed message
      else
        fail "#message, but it returned #{ stringified actual-value }"

    expect = (subject) ->

      to-equal: -> subject `equals` it
      to-be-a:  -> subject `must-be-a` it
      to-throw: -> subject `throws` it
      to-return: -> subject `returns` it

    {
      expect
    }