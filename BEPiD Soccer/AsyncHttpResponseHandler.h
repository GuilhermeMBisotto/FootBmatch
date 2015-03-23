
#import <Foundation/Foundation.h>

@interface AsyncHttpResponseHandler : NSObject
{
    NSMutableData * m_data;
    NSInteger m_statusCode;
}

-(void)onStart;
-(void)onSuccess:(NSMutableDictionary *)json;
-(void)onFailure:(NSMutableDictionary *)error;
-(void)onFinish;

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
-(void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
