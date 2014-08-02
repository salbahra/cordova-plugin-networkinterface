#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVInvokedUrlCommand.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface CDVNetworkInterface : CDVPlugin

- (void) getIPAddress:(CDVInvokedUrlCommand*)command;
- (void) getSSID:(CDVInvokedUrlCommand*)command;

@end
