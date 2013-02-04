execSync = require "exec-sync"
argv = require('optimist').argv
path = require "path"
fs = require "fs"

Help = require "./help"
FFmpeg = require "./ffmpeg"
Convert = require "./convert"
Gifsicle = require "./gifsicle"
class Gifufy

  @run: () ->

    [source, target, otherOptions...] = argv._

    Help.usage()

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

    glob = require "glob"

    gifs = glob.sync("#{workingDirPath}/*.gif")
    sortedGifs = gifs.sort (a,b)->
      firstFilename = path.basename(a)
      secondFilename = path.basename(b)

      if parseInt(firstFilename) < parseInt(secondFilename)
        return -1
      else if parseInt(firstFilename) > parseInt(secondFilename)
        return 1
      else
        return 0


    gifsicle = new Gifsicle
      src: sortedGifs
      dst: target
      debug: argv.debug

    gifsicle.convertToAnimatedGifSync()


module.exports = Gifufy

