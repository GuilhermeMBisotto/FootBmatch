//
//  HttpClientBase.m
//  Aproximar
//
//  Created by Enrique C. Melgarejo on 14/09/14.
//  Copyright (c) 2014 GreenB. All rights reserved.
//

#import "AppDelegate.h"
#import "HttpClientBase.h"
#import "AsyncHttpResponseHandler.h"

#define TIMEOUTINTERVAL 15
static NSString *m_userAgent = @"Aproximar Client (IOS) -v";

@interface HttpClientBase () <NSURLConnectionDelegate>
@end

@implementation HttpClientBase

+(void)useParse:(id) handler
{
    
        //fazer funcionalidade genérica.....
    NSLog(@"----------------------HttpClientBase");
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://beta.aproximar.greenb.com.br/api/student?institution=1000"];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:m_userAgent forHTTPHeaderField:@"User-Agent"];
    [request setTimeoutInterval:TIMEOUTINTERVAL];
    
    [NSURLConnection connectionWithRequest:request delegate: handler];
}

@end
