var networkinterface = function() {
};

networkinterface.getWiFiIPAddress = function( success, fail ) {
    cordova.exec( success, fail, "networkinterface", "getWiFiIPAddress", [] );
};

networkinterface.getCarrierIPAddress = function( success, fail ) {
    cordova.exec( success, fail, "networkinterface", "getCarrierIPAddress", [] );
};

networkinterface.getIPAddress = function( success, fail ) {
    cordova.exec( success, networkinterface.getCarrierIPAddress.bind( null, success, fail ), "networkinterface", "getWiFiIPAddress", [] );
};

networkinterface.getHttpProxyInformation = function( url, success, fail ) {
    cordova.exec( success, fail, "networkinterface", "getHttpProxyInformation", [url] );
};

module.exports = networkinterface;
