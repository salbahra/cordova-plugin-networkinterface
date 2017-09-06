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

//******************************************************
// Methods declared in header
//******************************************************

- (void) getWiFiIPAddress:(CDVInvokedUrlCommand*)command
{
    NSLog(@"getWiFiIPAddress start");
    //en0 is the interface for Wifi on iPhone
    NSArray* ipinfo = [self getInterfaceiIP:@"en0"];
    [self respondWithIPAddress:command ipinfo:ipinfo];
}

- (void) getCarrierIPAddress:(CDVInvokedUrlCommand*)command
{
    NSLog(@"getCarrierIPAddress");
    //pdp_ip0 is the interface for Carrier Connection on iPhone
    NSArray *ipinfo = [self getInterfaceiIP:@"pdp_ip0"];
    [self respondWithIPAddress:command ipinfo:ipinfo];
}

- (void) getHttpProxyInformation: (CDVInvokedUrlCommand*)command url:(NSString*)url 
{
    NSLog(@"getHttpProxyInformation start");
    //CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsMultipart:@[ipaddr, ipsubnet]];
    //CFNetworkCopyProxiesForURL is the function we need....
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Not implemented"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    NSLog(@"getHttpProxyInformation end");
}

@end

