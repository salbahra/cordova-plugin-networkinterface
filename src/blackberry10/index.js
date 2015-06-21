function getIP() {
    var con;

    try {
        con = window.qnx.webplatform.device.activeConnection;
    }
    catch ( e ) { return false; }

    if ( !con || con.type == "cellular" ) {
		return false;
    }
    return con.defaultGateways[0];
}

module.exports = {
    getIPAddress: function( success, fail, args, env ) {
        var result = new PluginResult( args, env ),
            ip = getIP();

        if ( !ip ) {
            result.error();
        } else {
            result.ok( ip );
        }
    }
};
