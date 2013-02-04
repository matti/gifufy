path = require "path"

class Help

  @usage: () ->
    HelpUtils.print "usage.txt"


class HelpUtils

  @helpFiles: path.join __dirname, "..", "support", "help"

  @print: (filename) ->
    console.log @readContentsSync path.join @helpFiles, filename

  @readContentsSync: (filename) ->
    require("fs").readFileSync(filename).toString()

module.exports = Help