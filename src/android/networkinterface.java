package com.albahra.plugin.networkinterface;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;
import android.content.Context;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;

public class networkinterface extends CordovaPlugin {
	public static final String GET_IP_ADDRESS="getIPAddress";

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		try {
			if (GET_IP_ADDRESS.equals(action)) {
				String ip = getIPAddress();
				String fail = "0.0.0.0";
				if (ip.equals(fail)) {
					callbackContext.error("Got no valid IP address");
					return false;
				}
				callbackContext.success(ip);
				return true;
			}
			callbackContext.error("Error no such method '" + action + "'");
			return false;
		} catch(Exception e) {
			callbackContext.error("Error while retrieving the IP address. " + e.getMessage());
			return false;
		}
	}

	private String getIPAddress() {
		String ipString = "";
		// has been tested and valid for Mobile Network and WiFi
		// System.out.println("Java IP Address: " + ipString);
		try {
			label1:
			for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements();) {
				NetworkInterface intf = en.nextElement();
				for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements();) {
					InetAddress inetAddress = enumIpAddr.nextElement();
					if (!inetAddress.isLoopbackAddress()) {
						ipString = inetAddress.getHostAddress().toString();
						/* Example output:
						 * System.out.println("Enumeration IP Address: " + ipString);
						 * 03-27 11:28:01.249: I/System.out(14553): Enumeration IP Address: fe80::12c3:7bff:fe07:54b3%wlan0
						 * 03-27 11:28:01.249: I/System.out(14553): Enumeration IP Address: 192.168.0.31
						*/
						if (isValidIpAddress(ipString)) {
							break label1;
						}
					}
				}
			}
		} catch (SocketException ex) {
		}
		return ipString;
	}
	
	private boolean isValidIpAddress(String str) {
	        String[] arr = str.split("\\.");
	        if (arr.length != 4) {
	            return false;
	        }
	        if (str.startsWith("0."))
	        	return false;
	        for (String item : arr) {
	            try {
	                int a = Integer.parseInt(item);
	                if (a < 0 || a > 255) {
	                    return false;
	                }
	            } catch (NumberFormatException ex) {
	                return false;
	            }
	        }
	        return true;
	}
}
