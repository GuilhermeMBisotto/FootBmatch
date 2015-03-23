
#import "HandlerLogin.h"


@interface HandlerLogin ()
{
    id<ILogin> m_loginEvents;
    NSString *m_facebookId;
}
@end

@implementation HandlerLogin
{
    NSUserDefaults *userDefaults;
}

-(id)initWithEvents:(id<ILogin>)eventReceiver
{
    return [self initWithEvents:eventReceiver andFacebookId:nil];
}

-(id)initWithEvents:(id<ILogin>)eventReceiver andFacebookId:(NSString *)facebookId
{
    if ([super init])
    {
        m_loginEvents = eventReceiver;
        m_facebookId = facebookId;
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

-(void)onSuccess:(NSMutableDictionary *)json
{
    
}

-(void)onFailure:(NSMutableDictionary *)error
{
   
}

-(void)onFinish
{

}

@end
