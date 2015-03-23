//
//  SessionManager.h
//  Aproximar
//
//  Created by Alisson L. Selistre on 17/09/14.
//  Copyright (c) 2014 GreenB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessionManager : NSObject

+(id)sharedManager;

-(NSString *)getAccount;
-(NSString *)getPass;
-(NSNumber *)getType;
-(NSNumber *)getId;
-(NSString *)getFacebookId;

-(void)setAccountWithInfo:(NSDictionary *)userInfo;
-(void)eraseAccount;

-(BOOL)hasLoginAndPass;
-(BOOL)hasFacebookId;

@end
