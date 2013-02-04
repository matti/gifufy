execSync = require "exec-sync"
argv = require('optimist').argv
path = require "path"
fs = require "fs"

Help = require "./help"
FFmpeg = require "./ffmpeg"
Convert = require "./convert"

class Gifufy

  @run: () ->

    [source, target, otherOptions...] = argv._

    Help.usage()

    workingDirPath = require("temp").mkdirSync()

    ffmpeg = new FFmpeg
      src: source
      dst: workingDirPath
      debug: argv.debug

    ffmpeg.convertToPNG()   # TODO: add Sync


    pngs = fs.readdirSync(workingDirPath)

    for png in pngs
      convert = new Convert
        src: path.join workingDirPath, png
        debug: argv.debug

      convert.convertToGIFSync()


    ###
    convert = new Convert
      src: workingDirPath

    convert.convertToGIF()
###

module.exports = Gifufy

