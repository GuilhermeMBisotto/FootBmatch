//
//  AppDelegate.h
//  BEPiD Soccer
//
//  Created by Bruno Rovea Soares on 10/03/15.
//  Copyright (c) 2015 Bruno Rovea Soares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;

@end

