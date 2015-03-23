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
    NSLog(@"Aquiiiiiiiiiii");
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [NSURLConnection connectionWithRequest:request delegate: handler];
}

@end
