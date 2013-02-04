execSync = require "exec-sync"

class Gifsicle

  constructor: (@options) ->
    throw "src not set" unless @options.src?
    throw "dst not set" unless @options.dst?

  convertToAnimatedGifSync: () ->

    sourceFiles = @options.src.join(" ")

    cmd = "gifsicle --colors 256 -O3 -Okeep-empty -d2 -l #{sourceFiles} -o '#{@options.dst}'"
    console.log cmd if @options.debug

    output = execSync cmd
    console.log output if @options.debug

module.exports = Gifsicle