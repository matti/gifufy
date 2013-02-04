execSync = require "exec-sync"

class Convert

  constructor: (@options) ->
    throw "src not set" unless @options.src?

  convertToGIFSync: () ->
    output = execSync "convert #{@options.src} #{@options.src}.gif"
    console.log output if @options.debug

module.exports = Convert