
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ILogin.h"
#import "IGroup.h"

@interface ServerConnection : NSObject

+(id)sharedManager;

-(void)loginWithFacebook:(id<FBGraphUser>)user events:(id<ILogin>)eventReceiver;
-(void)getGroupsByObjectIdUser:(NSString*)objectIdUser events:(id<IGroup>)eventReceiver;
@end
