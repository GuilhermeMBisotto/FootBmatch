
#import "AsyncHttpResponseHandler.h"
#import "ILogin.h"

@interface HandlerLogin : AsyncHttpResponseHandler

-(id)initWithEvents:(id<ILogin>)eventReceiver;
-(id)initWithEvents:(id<ILogin>)eventReceiver andFacebookId:(NSString *)facebookId;

@end
