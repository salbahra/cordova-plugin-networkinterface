var networkinterface = {
    
    getIPAddress: function (success, fail, resultType) {
            return Cordova.exec(success, fail, 
                    "com.albahra.plugins.networkinterface", 
                    "getIPAddress");
    }
};
