
  do ->

    new-writer = ->

      write = !-> [ (String arg) for arg in arguments ].join ' ' |> winjs.process.io.stdout

      writeln = !-> @write '\n' ; @write ...

      {
        write, writeln
      }

    #

    new-indented-writer = (indentation-size) ->

      writer = new-writer!

      level = 0

      spaces = -> ' ' * (level * indentation-size)

      #

      indent = !-> level++
      dedent = !-> level--

      get-indentation-level = -> level

      write = !-> writer.write ...
      writeln = !-> writer.writeln spaces! ; writer.write ...

      {
        indent, dedent,
        get-indentation-level,
        write, writeln
      }

    ##

    percentage = (value, total) ->

      if total is 0
        0
      else
        (value / total * 100).to-fixed 2

    #

    {
      new-indented-writer,
      percentage
    }