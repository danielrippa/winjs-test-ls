
  do ->

    as-string = ->

      switch typeof! it

        | \Undefined => \void
        | \Null => \null

        | \Function => Function.prototype.to-string.call it
        | \String => "'#it'"

        else JSON.stringify it

    #

    test-result = (success, message) -> { success, message }

    succeeded = -> test-result yes, it
    failed    = -> test-result  no, it

    #

    was-expected-to = (value, message) -> "Expected #{ value |> as-string } to #message"

    #

    equals = (one, another) ->

      message = one `was-expected-to` "be equal to #{ another |> as-string }"

      if one is another
        succeeded message
      else
        failed message

    #

    must-be-a = (value, type-name) ->

      actual-type = typeof! value

      message = value `was-expected-to` "be a #type-name"

      if (typeof! value) is type-name
        succeeded message
      else
        failed message

    #

    throws = (fn, required-message) ->

      message = fn `was-expected-to` "throw '#required-message'"

      try fn! ; return "#message, but it didnt throw any error"
      catch e

        if e.message is required-message
          succeeded message
        else
          failed "#message, but it threw '#{ e.message }'"

    #

    returns = (fn, expected-value) ->

      expected-value-as-string = expected-value |> as-string

      message = fn `was-expected-to` "return #expected-value-as-string"

      try result = fn!
      catch e => return failed "#message, but it threw '#{ e.message }'"

      result-as-string = result |> as-string

      if result-as-string is expected-value-as-string
        succeeded message
      else
        failed message

    #

    subject = (something) ->

      to-return: -> something `returns` it
      to-equal:  -> something `equals` it
      to-be-a:   -> something `must-be-a` it
      to-throw:  -> something `throws` it

    #

    {
      subject
    }