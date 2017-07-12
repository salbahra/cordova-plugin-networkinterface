Network Interface
=================

Network interface information plugin for Cordova/PhoneGap that supports Android, Blackberry 10, Browser, iOS, and Windows Phone 8.

## PhoneGap Build

To include the Network Interface plugin in your PhoneGap Build application, add this to your config.xml:

    <plugin name="cordova-plugin-networkinterface" source="npm" />

## Command Line Install

    cordova plugin add cordova-plugin-networkinterface

## Usage

The plugin creates the object `networkinterface` with the methods:
* getWiFiIPAddress(onSuccess, onError)
* getCarrierIPAddress(onSuccess, onError)

* getIPAddress(onSuccess, onError)

`This method is deprecated and uses the getWiFiIPAddress method.`

The onSuccess() callback is provided with two values: 

    function onSuccess(ip, subnet) { }

`Note: Subnet is only supported for iOS and Android currently`

The onError() callback is provided with a single value:

    function onError(error) { }

`Note: onError() will be called when an IP address can't be found. eg WiFi is disabled, no SIM card, Airplane mode etc.
`

Example:

	networkinterface.getWiFiIPAddress(function (ip) { alert(ip); });
	networkinterface.getCarrierIPAddress(function (ip) { alert(ip); });
    
    // with subnet and error handler
    networkinterface.getWiFiIPAddress(
        function (ip, subnet) { alert(ip + ":" + subnet); }, 
        function (err) { alert("Err: " + err); }
    );

## TODO

getCarrierIPAddress() is currently supported on iOS and Android only, need to add Blackberry 10, Browser, and Windows Phone 8 support

## License

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
