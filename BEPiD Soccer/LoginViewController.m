//
//  LoginViewController.m
//  BEPiD Soccer
//
//  Created by Bruno Rovea Soares on 10/03/15.
//  Copyright (c) 2015 Bruno Rovea Soares. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController()

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottom;




@end

@implementation LoginViewController
{
    CGFloat _initialConstant;
}

// A small offset so the button won't be immediately above the keyboard.
static CGFloat keyboardHeightOffset = 8.0f;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Registering for system notifications.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.username.text = self.emailFace;
    
}
- (IBAction)CriandoLogin:(id)sender
{
        PFUser *pfuser = [PFUser user];
        pfuser.username = self.username.text;
        pfuser.password = self.password.text;
        pfuser.email = self.username.text;
    
        [pfuser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error)
            {
                [self performSegueWithIdentifier:@"SueFromCreateUser" sender:self];
            }
            else
            {
               UIAlertView *myAlert =  [[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [myAlert show];
            }
        }];

}

//MARK: Keyboard Methods
- (IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    
    // Getting the keyboard frame and animation duration.
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    NSTimeInterval keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (!_initialConstant) {
        _initialConstant = _constraintBottom.constant;
    }
    
    // If screen can fit everything, leave the constant untouched.
    _constraintBottom.constant = MAX(keyboardFrame.size.height + keyboardHeightOffset, _initialConstant);
    [UIView animateWithDuration:keyboardAnimationDuration animations:^{
        // This method will automatically animate all views to satisfy new constants.
        [self.view layoutIfNeeded];
    }];
    
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    
    // Getting the keyboard frame and animation duration.
    NSTimeInterval keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Putting everything back to place.
    _constraintBottom.constant = _initialConstant;
    [UIView animateWithDuration:keyboardAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

@end
