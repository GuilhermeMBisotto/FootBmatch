
#import "Constants.h"

@protocol ILogin <NSObject>

-(void)OnLoginSucceded:(NSDictionary *)userInfo;
-(void)OnLoginError:(NSString *)error ErrorCode:(enum JsonErrorCode)errorCode;

@end
