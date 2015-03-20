//
//  AppDelegate.m
//  BEPiD Soccer
//
//  Created by Bruno Rovea Soares on 10/03/15.
//  Copyright (c) 2015 Bruno Rovea Soares. All rights reserved.
//

#import "AppDelegate.h"
//#import <Parse/Parse.h>
//#import <FacebookSDK/FacebookSDK.h>
//#import "ParseFacebookUtils.framework/Headers/PFFacebookUtils.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"To3BJyf3vGlicOKUGT7weOODEcMpNU9wpbXohNQC"
                  clientKey:@"Tps1kmOevHRuMHPz7FwzMYWsoiv1yq3xTbTwkt6G"];
    
    [FBProfilePictureView class];
    [FBLoginView class];
    
    [PFFacebookUtils initializeFacebook];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
}

@end
