#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVInvokedUrlCommand.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface CDVNetworkInterface : CDVPlugin

- (void) getIPAddress:(CDVInvokedUrlCommand*)command;

@end
