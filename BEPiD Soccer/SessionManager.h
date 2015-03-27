#import <Foundation/Foundation.h>

@interface SessionManager : NSObject

+(id)sharedManager;

-(NSString *)getAccount;
-(NSString *)getPass;
-(NSNumber *)getType;
-(NSNumber *)getId;
-(NSString *)getObjectIdUser;
-(NSString *)getFacebookId;

-(void)setAccountWithInfo:(NSDictionary *)userInfo;
-(void)eraseAccount;

-(BOOL)hasLoginAndPass;
-(BOOL)hasFacebookId;

@end
