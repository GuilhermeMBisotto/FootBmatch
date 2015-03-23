//
//  InitialViewController.m
//  BEPiD Soccer
//
//  Created by Bruno Rovea Soares on 10/03/15.
//  Copyright (c) 2015 Bruno Rovea Soares. All rights reserved.
//

#import "InitialViewController.h"
#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "AppDelegate.h"
#import "SessionManager.h"

@interface InitialViewController()<ILogin>

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property  NSString *emailFace;
@end

@implementation InitialViewController

-(void)viewDidLoad
{
    _loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
}

#pragma mark - FACEBOOK METHODS

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    [[ServerConnection sharedManager] loginWithFacebook:user events:self];
}

#pragma mark - VIEW METHODS

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueGoToLoginView"])
    {
        LoginViewController *mu = (LoginViewController *)[segue destinationViewController];
        mu.emailFace = self.emailFace;
    }
}

#pragma mark - LOGIN EVENTS

-(void)OnLoginSucceded:(NSDictionary *)userInfo
{
    [self performSegueWithIdentifier:@"SegueLoginSuccess" sender:self];
}

-(void)OnLoginError:(NSString *)error ErrorCode:(enum JsonErrorCode)errorCode
{
    
}

@end
