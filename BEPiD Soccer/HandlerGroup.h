
#import "AsyncHttpResponseHandler.h"
#import "IGroup.h"

@interface HandlerGroup : AsyncHttpResponseHandler

-(id)initWithEvents:(id<IGroup>)eventReceiver;
-(id)initWithEvents:(id<IGroup>)eventReceiver andGroupId:(NSString *)groupId;
@end
