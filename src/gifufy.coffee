execSync = require "exec-sync"
argv = require('optimist').argv
path = require "path"
fs = require "fs"
glob = require "glob"

Help = require "./help"
FFmpeg = require "./ffmpeg"
Convert = require "./convert"
Gifsicle = require "./gifsicle"

class Gifufy

  @run: () ->

    [source, target, otherOptions...] = argv._

    unless source? and target?
      Help.usage()
      process.exit(1)

    workingDirPath = require("temp").mkdirSync()

    ffmpeg = new FFmpeg
      src: source
      dst: workingDirPath
      debug: argv.debug

    ffmpeg.convertToPNGSync()


    pngs = fs.readdirSync(workingDirPath)

    for png in pngs
      convert = new Convert
        src: path.join workingDirPath, png
        debug: argv.debug

      convert.convertToGIFSync()


    gifs = glob.sync("#{workingDirPath}/*.gif")

    sortedGifs = gifs.sort (a,b)->
      aSequenceNumber = parseInt(path.basename(a))
      bSequenceNumber = parseInt(path.basename(b))

      return if aSequenceNumber < bSequenceNumber
        -1
      else if aSequenceNumber > bSequenceNumber
        1
      else
        0


    gifsicle = new Gifsicle
      src: sortedGifs
      dst: target
      debug: argv.debug

    gifsicle.convertToAnimatedGifSync()


module.exports = Gifufy

