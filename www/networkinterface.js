var exec = require('cordova/exec');
   
var networkinterface = function() {
};

Keyboard.getIPAddress = function(success, fail) {
    exec(success, fail, "networkinterface", "getIPAddress", []);
};

module.exports = networkinterface;
