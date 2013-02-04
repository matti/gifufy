execSync = require "exec-sync"
argv = require('optimist').argv
Help = require "./help"

class Gifufy

  @run: () ->

    [source, target, otherOptions...] = argv._

    Help.usage()

module.exports = Gifufy

