
#import "HandlerGroup.h"

@interface HandlerGroup ()
{
    id<IGroup> m_groupEvents;
}
@end

@implementation HandlerGroup
{
    NSUserDefaults *userDefaults;
}

-(id)initWithEvents:(id<IGroup>)eventReceiver
{
    return [self initWithEvents:eventReceiver andGroupId:nil];
}

-(id)initWithEvents:(id<IGroup>)eventReceiver andGroupId:(NSString *)groupId;
{
    if ([super init])
    {
        m_groupEvents = eventReceiver;
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

-(void)onSuccess:(NSMutableDictionary *)json
{
    NSLog(@"Get Group - onSuccess: %@",json);
    dispatch_async(dispatch_get_main_queue(), ^(void)
                   {
                       [m_groupEvents OnGetGroupByUserSucceded:json];
                   });
}

-(void)onFailure:(NSMutableDictionary *)error
{
    NSLog(@"Get Group - onFailure: %@",error);
}

-(void)onFinish
{
    
}


@end
