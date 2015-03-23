
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ILogin.h"

@interface ServerConnection : NSObject

+(id)sharedManager;

-(void)loginWithFacebook:(id<FBGraphUser>)user events:(id<ILogin>)eventReceiver;
@end
