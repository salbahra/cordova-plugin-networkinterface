package com.albahra.plugin.networkinterface;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONObject;
import org.json.JSONArray;
import org.json.JSONException;
import java.io.*;
import java.net.*;
import java.util.*;
import org.apache.http.conn.util.InetAddressUtils;

public class networkinterface extends CordovaPlugin {
	public static final String GET_IP_ADDRESS="getIPAddress";

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		try {
			if (GET_IP_ADDRESS.equals(action)) {
				String ip = getIPAddress();
				if (ip == "Error") {
					callbackContext.error("Error");
					return false;
				}
				callbackContext.success(ip);
				return true;
			}
			callbackContext.error("Error");
			return false;
		} catch(Exception e) {
			callbackContext.error("Error");
			return false;
		}
	}

	private static String getIPAddress() {
        try {
            List<NetworkInterface> interfaces = Collections.list(NetworkInterface.getNetworkInterfaces());
            for (NetworkInterface intf : interfaces) {
                List<InetAddress> addrs = Collections.list(intf.getInetAddresses());
                for (InetAddress addr : addrs) {
                    if (!addr.isLoopbackAddress() && !addr.isVirtual() && !addr.isPointToPoint()) {
                        String sAddr = addr.getHostAddress().toUpperCase();
                        boolean isIPv4 = InetAddressUtils.isIPv4Address(sAddr);
                        if (isIPv4)
                            return sAddr;
                    }
                }
            }
        } catch (Exception ex) { return "Error"; } // for now eat exceptions
        return "Error";
    }

}
