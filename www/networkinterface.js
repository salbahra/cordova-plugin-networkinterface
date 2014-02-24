var exec = require('cordova/exec');

var networkinterface = function() {
};

networkinterface.getIPAddress = function(success, fail) {
    exec(success, fail, "networkinterface", "getIPAddress", []);
};

module.exports = networkinterface;
