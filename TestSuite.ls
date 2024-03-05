
  do ->

    { nl-out, out } = dependency 'prelude.Console'
    { replicate } = dependency 'prelude.String'
    { expect } = dependency 'test.Expect'
    { new-test-suite-stats } = dependency 'test.TestSuiteStats'

    indent = -> nl-out replicate ' ', it

    new-test-suite = ->

      indentation = 0

      stats = new-test-suite-stats!

      scenario = (description, fn) ->

        nl-out!

        indentation += 2

        indent indentation
        out description

        fn!

        indentation -= 2

        if indentation is 0

          nl-out!

          for k, v of stats.get-summary!

            indent 2

            out "#k: #v"

          nl-out!

      should = (fn) ->

        indentation += 2

        { success, message } = fn!

        stats.record-result success

        nl-out!

        indent indentation

        if success
          out 'pass: '
        else
          out 'fail: '

        out message

        indentation -= 2

      {
        scenario, should, expect
      }

    {
      new-test-suite
    }
