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
//#import <SendGrid/SendGrid.h>
//#import <SendGrid/SendGridEmail.h>

@interface InitialViewController()<ILogin>

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property  NSString *emailFace;
@end

@implementation InitialViewController

-(void)viewDidLoad
{
    _loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    
//    SendGrid *sendgrid = [SendGrid apiUser:api_user apiKey:api_key];
//    
//    SendGridEmail *email = [[SendGridEmail alloc] init];
//    email.to = @"you@youreamil.com";
//    email.from = @"test@sendgrid.com";
//    email.subject = @"Sending with SendGrid is Fun";
//    email.html = @"and easy to do anywhere, even with Objective-C";
//
//    [sendgrid sendWithWeb:email];
    
//    [PFCloud callFunctionInBackground:@"hello"
//                       withParameters:@{}
//                                block:^(NSString *result, NSError *error) {
//                                    if (!error) {
//                                        // result is @"Hello world!"
//                                    }
//                                }];
    
    
    [PFCloud callFunctionInBackground:@"sendMail"
                       withParameters:@{@"toEmail":@"jadernunes.jbn@gmail.com",@"toName":@"Minnjie Xu",@"fromEmail":@"jadernunes.jbn@gmail.com",@"fromName":@"uudaddy",@"text":@"resetPasswordButtonPressed...",@"subject":@"myNestEgg ~ testing ManDrill email"}
                                block:^(NSString *result, NSError *error) {
                                    if (!error) {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset Passoword" message:@"Email Sent :-)"
                                                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                        [alert show];
                                        
                                    }
                                }];
    
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
    [[SessionManager sharedManager] setAccountWithInfo:userInfo];
    [self performSegueWithIdentifier:@"SegueLoginSuccess" sender:self];
}

-(void)OnLoginError:(NSString *)error ErrorCode:(enum JsonErrorCode)errorCode
{
    
}

@end
