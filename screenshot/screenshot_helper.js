var webpage = require('webpage')
  , system = require('system')
  , fs = require('fs')

if (system.args.length !== 2) {
  console.error('bad args')
}

var page = webpage.create()
page.viewportSize = { width: 1024, height: 768 }

page.open(system.args[1], function() {
    fs.write('/dev/stdout', page.renderBase64('PNG'), 'wb')
    phantom.exit()
})
