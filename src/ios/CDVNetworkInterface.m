#import "CDVNetworkInterface.h"

@implementation CDVNetworkInterface

- (NSArray *)getInterfaceiIP:(NSString *)interfaceName  {
    NSString *address = @"error";
    NSString *subnet = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;

    int ifAddrsGetResultSuccess = getifaddrs(&interfaces); // retrieve current interfaces, returns 0 on success
    
    if (ifAddrsGetResultSuccess == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                NSString* name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                // Check if interface the one we actually want to get the value for...
                if([name isEqualToString:interfaceName]) {
                    // Get NSString from C String
                    address = addr;
                    subnet = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];
                }
            }

            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }

    return (NSArray*)@[address, subnet];
}

-(void) respondWithIPAddress:(CDVInvokedUrlCommand*)command ipinfo:(NSArray*)ipinfo
{
    CDVPluginResult* pluginResult = nil;
    NSString* ipaddr = ipinfo[0];
    NSString* ipsubnet = ipinfo[1];

    if (ipaddr != nil && ![ipaddr isEqualToString:@"error"]) {
        NSDictionary* result = @{ @"ip": ipaddr, @"subnet": ipsubnet};
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No valid IP address identified"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (NSString*) getProxyType:(NSString*)cfProxyType
{
    NSString* proxyType =  @"DIRECT";
    
    if ([cfProxyType isEqualToString:@"kCFProxyTypeAutoConfigurationURL"])
    {
        proxyType = @"AUTOCONFIG";
    }
    else if ([cfProxyType isEqualToString:@"kCFProxyTypeHTTP"])
    {
        proxyType = @"HTTP";
    }
    else if ([cfProxyType isEqualToString:@"kCFProxyTypeHTTPS"])
    {
        proxyType = @"HTTP";
    }
    else if ([cfProxyType isEqualToString:@"kCFProxyTypeAutoConfigurationJavaScript"])
    {
        proxyType = @"AUTOJS";
    }
    else if ([cfProxyType isEqualToString:@"kCFProxyTypeFTP"])
    {
        proxyType = @"FTP";
    }
    else if ([cfProxyType isEqualToString:@"kCFProxyTypeSOCKS"])
    {
        proxyType = @"SOCKS";
    }
    
    return proxyType;
}

- (NSObject*) createProxyInformation:(NSDictionary*)proxy
{
    NSString *cfProxyType = proxy[@"kCFProxyTypeKey"];
    NSString *proxyType = [self getProxyType:cfProxyType];
    NSString *host = @"none";
    NSString *port = @"none";
    
    if (![proxyType isEqualToString:@"DIRECT"] && ![proxyType isEqualToString:@"AUTOCONFIG"] && ![proxyType isEqualToString:@"AUTOJS"])
    {
        host = proxy[@"kCFProxyHostNameKey"];
        port = proxy[@"kCFProxyPortNumberKey"];
    }
    
    return @{
             @"type": proxyType,
             @"host": host,
             @"port": port
             };
}

- (NSArray*) createProxiesArray:(NSArray*)proxies
{
    NSMutableArray *returnArray = [NSMutableArray arrayWithCapacity:[proxies count]];
    if([proxies count] < 1)
    {
        [returnArray addObject: @{
                                  @"type": @"DIRECT",
                                  @"host": @"none",
                                  @"port": @"none"
                                  }];
    }
    else
    {
        NSDictionary *proxyInfo = [proxies objectAtIndex:0];
        [returnArray addObject: [self createProxyInformation:proxyInfo]];
    }
    return [returnArray copy];
}

//******************************************************
// Methods declared in header
//******************************************************

- (void) getWiFiIPAddress:(CDVInvokedUrlCommand*)command
{
    //en0 is the interface for Wifi on iPhone
    NSArray* ipinfo = [self getInterfaceiIP:@"en0"];
    [self respondWithIPAddress:command ipinfo:ipinfo];
}

- (void) getCarrierIPAddress:(CDVInvokedUrlCommand*)command
{
    //pdp_ip0 is the interface for Carrier Connection on iPhone
    NSArray *ipinfo = [self getInterfaceiIP:@"pdp_ip0"];
    [self respondWithIPAddress:command ipinfo:ipinfo];
}

- (void) getHttpProxyInformation: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    if([command.arguments count] > 0)
    {
        NSString *url = [command.arguments objectAtIndex: 0];
        
        CFDictionaryRef proxySettingsRef =CFNetworkCopySystemProxySettings();
        CFURLRef urlRef = (__bridge CFURLRef)[NSURL URLWithString:url];
        CFArrayRef proxiesRef = CFNetworkCopyProxiesForURL(urlRef, proxySettingsRef);
        NSArray *proxies = [self createProxiesArray:(__bridge NSArray*)proxiesRef];
    
        CFRelease(proxySettingsRef);
        CFRelease(proxiesRef);
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray: proxies];
    } 
    else 
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No URL Specified"];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end

