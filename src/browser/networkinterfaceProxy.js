function getWiFiIPAddress( callback ) {
    var ips = [];

    var RTCPeerConnection = window.RTCPeerConnection ||
        window.webkitRTCPeerConnection || window.mozRTCPeerConnection;

    var pc = new RTCPeerConnection( {

        // Don't specify any stun/turn servers, otherwise you will
        // also find your public IP addresses.
        iceServers: []
    } );

    // Add a media line, this is needed to activate candidate gathering.
    pc.createDataChannel( "" );

    // The `onicecandidate` is triggered whenever a candidate has been found.
    pc.onicecandidate = function( e ) {

        // Candidate gathering completed.
        if ( !e.candidate ) {
            pc.close();
            callback( ips[ 0 ] );
            return;
        }
        var ip = /^candidate:.+ (\S+) \d+ typ/.exec( e.candidate.candidate )[ 1 ];

        // Avoid duplicate entries (tcp/udp)
        if ( ips.indexOf( ip ) == -1 ) {
            ips.push( ip );
        }
    };
    pc.createOffer( function( sdp ) {
        pc.setLocalDescription( sdp );
    }, function onerror() {} );
}

module.exports = {
  getWiFiIPAddress: getWiFiIPAddress
};

require( "cordova/exec/proxy" ).add( "networkinterface", module.exports );
