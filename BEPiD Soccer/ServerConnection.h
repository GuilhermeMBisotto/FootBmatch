
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ILogin.h"

@interface ServerConnection : NSObject

+(id)sharedManager;

-(void)loginWithUser:(NSString *)user password:(NSString *)password events:(id<ILogin>)eventReceiver;
-(void)loginDireto:(id<ILogin>)eventReceiver;

@end
