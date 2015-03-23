
#import "AsyncHttpResponseHandler.h"
#import "Constants.h"
#import "SessionManager.h"
#import "ServerConnection.h"

@interface AsyncHttpResponseHandler() <NSURLConnectionDataDelegate, ILogin>
{
    NSMutableURLRequest *lastRequest;
}
@end

@implementation AsyncHttpResponseHandler

-(id)init
{
    if (self = [super init])
    {
        m_data = [NSMutableData data];
    }
    return self;
}

-(void)onStart
{
    
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

-(void)OnLoginSucceded:(NSDictionary *)userInfo
{
    
}

-(void)OnLoginError:(NSString *)error ErrorCode:(enum JsonErrorCode)errorCode
{
    
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}

@end
