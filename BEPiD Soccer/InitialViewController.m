//
//  InitialViewController.m
//  BEPiD Soccer
//
//  Created by Bruno Rovea Soares on 10/03/15.
//  Copyright (c) 2015 Bruno Rovea Soares. All rights reserved.
//

#import "InitialViewController.h"
#import "LoginViewController.h"

@interface InitialViewController()

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property  NSString *emailFace;
@end

@implementation InitialViewController

-(void)viewDidLoad
{
    _loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
   
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"email" equalTo:[user objectForKey:@"email"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            if(objects.count <= 0)
            {
                self.emailFace = [user objectForKey:@"email"];
                [self performSegueWithIdentifier:@"segueGoToLoginView" sender:user];
            }
            else
            {
                [self performSegueWithIdentifier:@"SegueLoginSuccess" sender:user];
            }
        } else
        {
            
        }
    }];
    
    
//    PFUser *pfuser = [PFUser user];
//    pfuser.username = @"jjj";
//    pfuser.password = @"password";
//    
//    [pfuser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error)
//        {
//            
////            NSData *imageData = UIImagePNGRepresentation(self.profile);
////            PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
////            
////            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
////            userPhoto[@"imageName"] = @"My trip to Hawaii!";
////            userPhoto[@"imageFile"] = imageFile;
////            [userPhoto saveInBackground];
//        }
//        else NSLog(@"Fodac");
//    }];
//    NSData *imageData = UIImagePNGRepresentation(user.id);
//    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
//    
//    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
//        [pfuser setObject:imageFile forKey:@"profilePic"];
//        [pfuser saveInBackground];
//    
//    }
}
    
    //self.profilePictureView.profileID = user.id;
    //self.nameLabel.text = user.name;
    //_statusLabel.text = [NSString stringWithFormat:@"You're logged in as %@", user.name];

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    //_statusLabel.text = @"You're logged in as";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueGoToLoginView"])
    {
        LoginViewController *mu = (LoginViewController *)[segue destinationViewController];
        mu.emailFace = self.emailFace;
    }
    if([segue.identifier isEqualToString:@"SegueLoginSuccess"])
    {
        
    }
    
}

@end
