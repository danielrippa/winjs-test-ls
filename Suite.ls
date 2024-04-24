
  do ->

    { new-indented-writer, percentage } = dependency 'test.Utils'
    { subject } = dependency 'test.Subject'

    new-test-suite-stats = ->

      passed = 0
      failed = 0

      #

      record-success = !-> passed := passed + 1
      record-failure = !-> failed := failed + 1

      record-result = (success) !->

        if success
          record-success!
        else
          record-failure!

      get-summary = ->

        total = passed + failed

        passed-percentage = percentage passed, total
        failed-percentage = percentage failed, total

        {
          passed, failed,
          total,
          passed-percentage, failed-percentage
        }

      {
        record-result,
        get-summary
      }

    ##

    new-test-suite = ->

      { record-result, get-summary: stats-summary } = new-test-suite-stats!

      { indent, dedent, write, writeln, get-indentation-level: indentation-level } = new-indented-writer 2

      #

      scenario = (description, fn) ->

        if (typeof! fn) isnt \Function
          throw new Error 'fn must be a Function'

        indent!

        writeln!
        writeln description
        writeln!

        fn!

        dedent!

        if indentation-level! is 0

          indent!

          writeln!

          for k,v of stats-summary!

            writeln k, v

          writeln!

      #

      expect = (fn) ->

        if (typeof! fn) isnt \Function
          throw new Error "fn must be a Function"

        indent!

        { success, message } = fn!

        record-result success

        writeln (if success then 'pass:' else 'fail:'), message

        dedent!

      {
        scenario, expect, subject
      }

    {
      new-test-suite
    }
