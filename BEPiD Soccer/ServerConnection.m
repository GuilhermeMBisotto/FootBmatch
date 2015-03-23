
#import "ServerConnection.h"
#import "HandlerLogin.h"
#import "HttpClientBase.h"

@interface ServerConnection()
{
    BOOL m_bIsRequestingLogin;
}
@end

@implementation ServerConnection

#pragma mark - Singleton Methods

+(id)sharedManager
{
    static ServerConnection *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void)loginWithUser:(NSString *)user password:(NSString *)password events:(id<ILogin>)eventReceiver
{
    
}
-(void)loginDireto:(id<ILogin>)eventReceiver
{
    @try {
        NSLog(@"aaaaaaaaa");
//        NetworkStatus internetStatus = [m_sReachability currentReachabilityStatus];
//        if (internetStatus == NotReachable)
//        {
//            [eventReceiver OnLoginError:NO_NETWORK ErrorCode:NoNetwork];
//            return;
//        }
        
        HandlerLogin *handler = [[HandlerLogin alloc] initWithEvents:eventReceiver];
        [HttpClientBase useParse:handler];
    }
    @catch (NSException *exception)
    {
        dispatch_async(dispatch_get_main_queue(), ^(void)
                       {
                           [eventReceiver OnLoginError:COULD_NOT_CONNECT ErrorCode:Fail];
                       });
    }
    @finally {
    }
}

@end
