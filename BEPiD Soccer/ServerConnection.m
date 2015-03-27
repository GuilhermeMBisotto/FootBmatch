
#import "ServerConnection.h"
#import "HandlerLogin.h"
#import "HttpClientBase.h"
#import "HandlerGroup.h"

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

#pragma mark - Login With Facebook

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
                    PFUser *userA = (PFUser*)[objects objectAtIndex:0];
                    NSDictionary *userToAdd = @{@"objectIdUser":userA.objectId,
                                                @"facebookId":[user objectForKey:@"id"]
                                                };
                    
                    json = [[NSMutableDictionary alloc]initWithDictionary:@{@"result":userToAdd}];
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

#pragma mark - Get Group by User

-(void)getGroupsByObjectIdUser:(NSString*)objectIdUser events:(id<IGroup>)eventReceiver
{
    @try
    {
        HandlerGroup *handler = [[HandlerGroup alloc] initWithEvents:eventReceiver];
        
        static NSMutableDictionary *json;
        static NSDictionary *dicGroup;
        static NSMutableArray *ListGroup;
        
        PFUser *user = [PFUser objectWithoutDataWithObjectId:objectIdUser];
        
        PFQuery *queryUserGroup = [PFQuery queryWithClassName:@"User_Group"];
        [queryUserGroup whereKey:@"objectIdUser" equalTo:user];
        
        [queryUserGroup findObjectsInBackgroundWithBlock:^(NSArray *objectsUserGroup, NSError *error) {
            if (!error)
            {
                if(objectsUserGroup.count > 0)
                {
                    PFQuery *queryGroup = [PFQuery queryWithClassName:@"Group"];
                    NSMutableArray *asdf = [[NSMutableArray alloc]initWithObjects:nil];
                    
                    for(PFObject *userGroup in objectsUserGroup)
                    {
                        PFObject *grupo = (PFObject*)[userGroup objectForKey:@"objectIdGroup"];
                        [asdf addObject:grupo.objectId];
                    }
                    
                    [queryGroup whereKey:@"objectId"containedIn:asdf];
                    [queryGroup findObjectsInBackgroundWithBlock:^(NSArray *objectsGroup, NSError *error) {
                        if (!error)
                        {
                            ListGroup = [[NSMutableArray alloc]initWithObjects:nil];
                            for(PFObject *grupoUser in objectsGroup)
                            {
                                PFUser *userOWner = (PFUser*)[grupoUser objectForKey:@"objectIdUserOwner"];
                                dicGroup = @{@"objectId":grupoUser.objectId,
                                             @"name":[grupoUser objectForKey:@"name"],
                                             @"objectIdUserOwner":userOWner.objectId
                                             };
                                [ListGroup addObject:dicGroup];
                            }
                            
                            json = [[NSMutableDictionary alloc]initWithDictionary:@{@"Result":ListGroup}];
                            [handler onSuccess:json];
                        }
                    }];
                }
                else
                {
                    json = [[NSMutableDictionary alloc]initWithDictionary:@{@"Result":error}];
                    [handler onFailure:json];
                }
            } else
            {
                json = [[NSMutableDictionary alloc]initWithDictionary:@{@"Result":error}];
                [handler onFailure:json];
            }
        }];
    }
    @catch (NSException *exception)
    {
        dispatch_async(dispatch_get_main_queue(), ^(void)
                       {
                           [eventReceiver OnGetGroupByUserError:COULD_NOT_CONNECT ErrorCode:Fail];
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
