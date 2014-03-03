using WPCordovaClassLib.Cordova;
using WPCordovaClassLib.Cordova.Commands;
using WPCordovaClassLib.Cordova.JSON;
using System.Collections.Generic;

namespace Cordova.Extension.Commands
{
    public class networkinterface : BaseCommand
    {
        public void getIPAddress(string options)
        {
            try
            {
                List<string> ipAddresses = new List<string>();
                var hostnames = Windows.Networking.Connectivity.NetworkInformation.GetHostNames();
                foreach (var hn in hostnames)
                {
                    //IanaInterfaceType == 71 => Wifi
                    //IanaInterfaceType == 6 => Ethernet (Emulator)
                    if (hn.IPInformation != null &&
                        (hn.IPInformation.NetworkAdapter.IanaInterfaceType == 71
                        || hn.IPInformation.NetworkAdapter.IanaInterfaceType == 6))
                    {
                        string ipAddress = hn.DisplayName;
                        ipAddresses.Add(ipAddress);
                    }
                }

                if (ipAddresses.Count < 1)
                {
                    DispatchCommandResult(new PluginResult(PluginResult.Status.ERROR));
                    return;
                }
                else if (ipAddresses.Count == 1)
                {
                    DispatchCommandResult(new PluginResult(PluginResult.Status.OK, ipAddresses[0]));
                    return;
                }
                else
                {
                    //if multiple suitable address were found use the last one
                    //(regularly the external interface of an emulated device)
                    DispatchCommandResult(new PluginResult(PluginResult.Status.OK, ipAddresses[ipAddresses.Count - 1]));
                    return;
                }
            }
            catch
            {
                DispatchCommandResult(new PluginResult(PluginResult.Status.ERROR));
            }

        }
    }
}
