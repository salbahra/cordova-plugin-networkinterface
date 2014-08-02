var networkinterface = function() {
};

networkinterface.getIPAddress = function(success, fail) {
    cordova.exec(success, fail, "networkinterface", "getIPAddress", []);
};

networkinterface.getSSID = function(success, fail) {
    cordova.exec(success, fail, "networkinterface", "getSSID", []);
};

module.exports = networkinterface;
