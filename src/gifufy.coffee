execSync = require "exec-sync"
argv = require('optimist').argv

class Gifufy

  @run: () ->

    [source, target, otherOptions...] = argv._

    console.log source
    console.log target


module.exports = Gifufy

