Network Interface
=================

Network interface information plugin for Cordova/PhoneGap that supports iOS.

## Usage

Install the plugin using the CLI, for instance with PhoneGap:

	phonegap local plugin add https://github.com/salbahra/NetworkInterFacePlugin

The plugin creates the object `cordova.plugins.networkinterface` with the methods `getIPAddress(IP, onSuccess, onError)`.

Example:

	cordova.plugins.networkinterface.getIPAddress(function (ip) { alert(ip); });

## Notes

## License

The MIT License (MIT)

Copyright (c) 2013 Albahra.com

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
