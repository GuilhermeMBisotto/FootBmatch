//
//  SessionManager.m
//  Aproximar
//
//  Created by Alisson L. Selistre on 17/09/14.
//  Copyright (c) 2014 GreenB. All rights reserved.
//

#import "SessionManager.h"
#import "KeychainItemWrapper.h"
#import "Constants.h"

static KeychainItemWrapper *keychainPassword;

@implementation SessionManager
+(id)sharedManager
{
    static SessionManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        keychainPassword = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:nil];
    });
    
    return sharedMyManager;
}

-(NSString *)getAccount
{
    NSString *string = [keychainPassword objectForKey:(__bridge id)kSecAttrAccount];
    return string;
}

-(NSString *)getPass
{
    NSString *string = [keychainPassword objectForKey:(__bridge id)kSecValueData];
    return string;
}

-(NSNumber *)getType
{
    NSDictionary *dicDescription = [self getDescriptionDictionary];
    
    NSInteger idType = [dicDescription[@"type"] integerValue];
    NSNumber *userType = [NSNumber numberWithInteger:idType];
    return userType;
}

-(NSNumber *)getId
{
    NSDictionary *dicDescription = [self getDescriptionDictionary];
    
    NSInteger idInteger = [dicDescription[@"id"] integerValue];
    NSNumber *userId = [NSNumber numberWithInteger:idInteger];
    return userId;
}

-(NSString *)getFacebookId
{
    NSDictionary *dicDescription = [self getDescriptionDictionary];
    
    NSString *facebookId = dicDescription[@"facebookId"];
    return facebookId;
}

-(void)setAccountWithInfo:(NSDictionary *)userInfo
{
    NSMutableDictionary *dicDescription = [self getDescriptionDictionary];
    if (dicDescription == nil)
        dicDescription = [[NSMutableDictionary alloc] init];
    
    if (userInfo[@"facebookId"])
        [dicDescription setObject:userInfo[@"facebookId"] forKey:@"facebookId"];
    
    
    if (dicDescription.count > 0)
        [self saveDescriptionDictionary:dicDescription];
}

-(void)eraseAccount
{
    [keychainPassword setObject:@"" forKey:(__bridge id)kSecAttrAccount];
    [keychainPassword setObject:@"" forKey:(__bridge id)kSecValueData];
    [keychainPassword setObject:@"" forKey:(__bridge id)kSecAttrDescription];
}

-(BOOL)hasLoginAndPass
{
    NSString *account = [self getAccount];
    NSString *pass = [self getPass];

    if ((account && ![account isEqualToString:@""]) && (pass && ![pass isEqualToString:@""]))
    {
        return YES;
    }
    
    return NO;
}

-(BOOL)hasFacebookId
{
    NSString *facebookId = [self getFacebookId];
    
    if (facebookId)
        return YES;
    
    return NO;
}

#pragma mark - utils

-(BOOL)saveDescriptionDictionary:(NSDictionary *)dic
{
    NSString * error = nil;
    
    //converte o dicionário em XML NSData
    NSData *tempData = [NSPropertyListSerialization dataFromPropertyList:dic format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    
    if (error){
        NSLog(@"%@", error);
        return NO;
    }
    
    //converte a data como XML para string
    NSString *xml = [[NSString alloc] initWithBytes:[tempData bytes] length:[tempData length] encoding:NSUTF8StringEncoding];
    [keychainPassword setObject:xml forKey:(__bridge id)kSecAttrDescription];
    return YES;
}

-(NSMutableDictionary *)getDescriptionDictionary
{
    NSError *error;
    NSMutableDictionary *dic;
    
    //recebe o que tem na description como string
    NSString *dicHasString = [keychainPassword objectForKey:(__bridge id)kSecAttrDescription];
    
    //verifica se é válido
    if (dicHasString && dicHasString.length)
    {
        NSData *tempData = [dicHasString dataUsingEncoding:NSUTF8StringEncoding];
        
        //converte a string em dicionário
        dic = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:nil error:&error];
        
        if (error) {
            NSLog(@"%@", error);
            return nil;
        }
    }
    else
    {
        dic = [[NSMutableDictionary alloc] init];
    }
    return dic;
}

@end
