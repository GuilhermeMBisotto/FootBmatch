
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

-(void)loginWithFacebook:(NSDictionary*)user events:(id<ILogin>)eventReceiver
{
    @try {
        
        //garante que não ocorram 2 requisições iguais antes de receber uma resposta
        if ([self getReqLogin]) return;
        [self setReqLogin:YES];
        
        HandlerLogin *handler = [[HandlerLogin alloc] initWithEvents:eventReceiver];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];
        
        static NSMutableDictionary *json;
        
        PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query whereKey:@"email" equalTo:[user objectForKey:@"email"]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error)
            {
                if(objects.count > 0)
                {
                    json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                    [handler onSuccess:json];
                }
                else
                {
                    json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                    [handler onFailure:json];
                }
            } else
            {
                json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [handler onFailure:json];
            }
        }];
        
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

-(void)setReqLogin:(BOOL)bValue
{
    m_bIsRequestingLogin = bValue;
}

-(BOOL)getReqLogin
{
    return m_bIsRequestingLogin;
}

@end
