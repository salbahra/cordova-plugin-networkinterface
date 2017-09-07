#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVInvokedUrlCommand.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface CDVNetworkInterface : CDVPlugin

- (void) getWiFiIPAddress:(CDVInvokedUrlCommand*)command;
- (void) getCarrierIPAddress:(CDVInvokedUrlCommand*)command;
- (void) getHttpProxyInformation:(CDVInvokedUrlCommand*)command;

@end
