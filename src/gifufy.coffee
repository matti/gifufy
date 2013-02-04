execSync = require "exec-sync"
argv = require('optimist').argv

Help = require "./help"
FFmpeg = require "./ffmpeg"

class Gifufy

  @run: () ->

    [source, target, otherOptions...] = argv._

    Help.usage()

    workingDirPath = require("temp").mkdirSync()

    ffmpeg = new FFmpeg
      src: source
      dst: workingDirPath

    ffmpeg.convertToPNG()


module.exports = Gifufy

