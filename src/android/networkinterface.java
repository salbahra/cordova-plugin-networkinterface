package com.albahra.plugin.networkinterface;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;

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
		WifiManager wifiManager = (WifiManager) getSystemService(WIFI_SERVICE);
		WifiInfo wifiInfo = wifiManager.getConnectionInfo();
		int ip = wifiInfo.getIpAddress();

		String ipString = String.format(
			"%d.%d.%d.%d",
			(ip & 0xff),
			(ip >> 8 & 0xff),
			(ip >> 16 & 0xff),
			(ip >> 24 & 0xff)
		);

		return ipString;
	}
}
