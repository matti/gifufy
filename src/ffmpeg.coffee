class FFmpeg

  constructor: (@options) ->
    throw "src not set" unless @options.src?
    throw "dst not set" unless @options.dst?

  convertToPNG: () ->
    execSync = require "exec-sync"
    path = require "path"
    destination = path.join @options.dst, "%d.png"

    cmd = "ffmpeg -loglevel quiet -i '#{@options.src}' '#{destination}'"

    output = execSync cmd

    console.log output if @options.debug


module.exports = FFmpeg
