
  do ->

    percentage = (value, total) ->

      if total is 0
        0
      else
        (value / total * 100).to-fixed 2

    new-test-suite-stats = ->

      passed = 0
      failed = 0

      record-success: -> passed := passed + 1
      record-failure: -> failed := failed + 1

      record-result: (success) ->
        if success
          @record-success!
        else
          @record-failure!

      get-summary: ->

        total = passed + failed

        passed-percentage = percentage passed, total
        failed-percentage = percentage failed, total

        {
          passed, failed,
          total,
          passed-percentage, failed-percentage
        }

    {
      new-test-suite-stats
    }