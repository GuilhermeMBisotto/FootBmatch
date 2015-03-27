
#import "Constants.h"

@protocol IGroup <NSObject>

-(void)OnGetGroupByUserSucceded:(NSDictionary *)userInfo;
-(void)OnGetGroupByUserError:(NSString *)error ErrorCode:(enum JsonErrorCode)errorCode;

@end