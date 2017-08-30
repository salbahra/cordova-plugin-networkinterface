var networkinterface = function() {
};

networkinterface.getIPAddress = function( success, fail ) {
    cordova.exec( success, fail, "networkinterface", "getWiFiIPAddress", [] );
};

networkinterface.getWiFiIPAddress = function( success, fail ) {
    cordova.exec( success, fail, "networkinterface", "getWiFiIPAddress", [] );
};

networkinterface.getCarrierIPAddress = function( success, fail ) {
    cordova.exec( success, fail, "networkinterface", "getCarrierIPAddress", [] );
};

networkinterface.getHttpProxyInformation = function(url, success, fail ) {
    cordova.exec( success, fail, "networkinterface", "getHttpProxyInformation", [url] );
};

module.exports = networkinterface;
