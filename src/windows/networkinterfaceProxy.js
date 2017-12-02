function getWiFiIPAddress(success, failure) {
  
    var winNetConn = Windows.Networking.Connectivity;
    var networkInfo = winNetConn.NetworkInformation;
  
    var hostnames = networkInfo.getHostNames();
  
    var addresses = [];
  
    for (const hostname of hostnames) {
      if (hostname.ipInformation !== null && (hostname.ipInformation.networkAdapter.ianaInterfaceType == 71 || hostname.ipInformation.networkAdapter.ianaInterfaceType == 6)) {
        addresses.push(hostname.displayName);
      }
    }
  
    if (addresses.length) {
      success(addresses[0]);
    } else {
      failure();
    }
  
  }
  
  
  module.exports = {
    getWiFiIPAddress: getWiFiIPAddress
  };
  
  
  require('cordova/exec/proxy').add('networkinterface', module.exports);