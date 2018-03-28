Network Interface
=================

Network interface information plugin for Cordova/PhoneGap that supports Android, Browser, iOS, and Windows 10.

## Command Line Install

    cordova plugin add cordova-plugin-networkinterface

## PhoneGap Build

To include the Network Interface plugin in your PhoneGap Build application, add this to your config.xml:

    <plugin name="cordova-plugin-networkinterface" source="npm" />

## Ionic 2+ (w/ Typescript) Usage

First install the wrapper:

```sh
npm install @ionic-native/network-interface
```

Define it in your modules:

```ts
import { NetworkInterface } from '@ionic-native/network-interface';

@NgModule( {
    ...
    providers: [
        NetworkInterface
    ],
} )
```

Then use it as follows:

```ts
import { NetworkInterface } from '@ionic-native/network-interface';

constructor( private networkInterface: NetworkInterface ) {
    this.networkInterface.getWiFiIPAddress( ip => alert( ip ) );
    this.networkInterface.getCarrierIPAddress( ip => alert( ip ) );
}
```

## Global Usage

The plugin creates the global object `networkinterface`, with the following methods:

* getWiFiIPAddress(onSuccess, onError)
* getCarrierIPAddress(onSuccess, onError)
* getHttpProxyInformation (url, onSuccess, onError)

### Using getWiFiIPAddress and getCarrierIPAddress
The onSuccess() callback has one argument object with the properties `ip` and `subnet` (changed in 2.x). The onError() callback is provided with a single value describing the error.

```javascript
function onSuccess( ipInformation ) {
    alert( "IP: " + ipInformation.ip + " subnet:" + ipInformation.subnet );
}

function onError( error ) {

    // Note: onError() will be called when an IP address can't be found. eg WiFi is disabled, no SIM card, Airplane mode etc.
    alert( error );
}

networkinterface.getWiFiIPAddress( onSuccess, onError );
networkinterface.getCarrierIPAddress( onSuccess, onError );
```

### Using getHttpProxyInformation
This function gets the relevant proxies for the passed URL in order of application. `onSuccess` we will get an array of objects, each having a `type`, `host` and `port` property. Where the url is not passed via a proxy, the `type` is "DIRECT" and both the host and port properties are set to "none"

```javascript
var url = "www.github.com"; //The url you want to find out the proxies for.

function onSuccess( proxyInformation ) {
    proxyInformation.forEach( function( proxy ) {
        alert( "Type:" + proxy.type + " Host:" + proxy.host + " Port:" + proxt.port );
    } );
}

function onError( error ) {

    // Note: onSuccess() will be called where there is no applicable proxy, not onError.
    alert( error );
}

networkinterface.getHttpProxyInformation( url, resolve, reject );
```

The type can be any of the following:
* DIRECT - Not passing through a proxy. `host`/`port` values will be "none"
* SOCKS
* HTTP
* HTTPS - iOS Only, seems to default back to HTTP
* AUTOJS - iOS Only, proxy determined by AutoConfiguration Script. `host`/`port` values will be "none"
* AUTOCONFIG - iOS Only, proxy determined by configuration at a URK `host`/`port` values will be "none"

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
