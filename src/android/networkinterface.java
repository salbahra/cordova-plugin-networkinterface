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
import android.util.Log;

import java.net.InetAddress;
import java.net.Inet4Address;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Collections;
import java.util.List;
import java.util.Enumeration;
import java.util.logging.*;

public class networkinterface extends CordovaPlugin {
	public static final String GET__WIFI_IP_ADDRESS="getWiFiIPAddress";
	public static final String GET_CARRIER_IP_ADDRESS="getCarrierIPAddress";
	private static final String TAG = "cordova-plugin-networkinterface";

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		try {
			if (GET__WIFI_IP_ADDRESS.equals(action)) {
				String ip = getWiFiIPAddress();
				String fail = "0.0.0.0";
				if (ip.equals(fail)) {
					callbackContext.error("No valid IP address identified");
					return false;
				}
				callbackContext.success(ip);
				return true;
			} else if (GET_CARRIER_IP_ADDRESS.equals(action)) {
				String ip = getCarrierIPAddress();
				String fail = "0.0.0.0";
				if (ip.equals(fail)) {
					callbackContext.error("No valid IP address identified");
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

	private String getWiFiIPAddress() {
		WifiManager wifiManager = (WifiManager) cordova.getActivity().getSystemService(Context.WIFI_SERVICE);
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



	private String getCarrierIPAddress() { 
	  try {
	    for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements();) {
	       NetworkInterface intf = (NetworkInterface) en.nextElement();
	       //Log.e(TAG, "Interface: " + intf.toString() + " name: " + intf.getName() + " display nane: " + intf.getDisplayName() );
	       for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements();) {
	          InetAddress inetAddress = enumIpAddr.nextElement();
	          if (!inetAddress.isLoopbackAddress() && (!intf.getName().equals("wlan0")) && inetAddress instanceof Inet4Address) {
	             String ipaddress = inetAddress.getHostAddress().toString();
	             return ipaddress;
	          }
	       }
	    }
	  } catch (SocketException ex) {
	     Log.e(TAG, "Exception in Get IP Address: " + ex.toString());
	  }
	  return null;
	}


}
