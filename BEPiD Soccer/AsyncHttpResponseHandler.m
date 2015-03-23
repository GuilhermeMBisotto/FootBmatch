
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
    NSError *error = nil;
    NSString *strError = @"";
    
    if ([m_data length] == 0)
    {
        strError = UNEXPECTED_SERVER_ERROR;
        NSMutableDictionary *dicError = [NSMutableDictionary dictionaryWithObjects:@[strError, [NSNumber numberWithInt:NotFound]] forKeys:@[@"Message", @"Code"]];
        [self onFailure:dicError];
    }
    else
    {
        NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:m_data options:NSJSONReadingMutableContainers error:&error];
        
        if (!json || error)
        {
            NSMutableDictionary *dicError = [NSMutableDictionary dictionaryWithObjects:@[strError, [NSNumber numberWithInt:Fail]] forKeys:@[@"Message", @"Code"]];
            [self onFailure:dicError];
        }
        else
        {
            [self onSuccess:json];
        }
    }
}

#pragma mark - NSURLConnection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
    m_statusCode = [response statusCode];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [m_data appendData:data];
}

@end
