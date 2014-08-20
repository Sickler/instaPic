//
//  ViewController.m
//  InstaPic
//
//  Created by Steven Sickler on 8/18/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *logInLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property NSArray *persons;
@property (weak, nonatomic) IBOutlet UIButton *createAccount;
@property (weak, nonatomic) IBOutlet UIButton *logIn;
@property BOOL isSignIn;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.userNameField setAutocorrectionType:UITextAutocorrectionTypeNo];
    self.createAccount.hidden = YES;
    [self.passwordField setSecureTextEntry:YES];
   [self.passwordField setAutocorrectionType:UITextAutocorrectionTypeNo];
    self.isSignIn = YES;

}

//Below is used to first test functionality in connecting to Parse
//- (IBAction)didTapButton:(id)sender {
//
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
//}



-(IBAction)onSignUpButtonPressed:(UIButton *)sender {

    if ([sender.titleLabel.text isEqualToString:@"Sign-Up"]) {
        self.isSignIn = NO;
        [sender setTitle:@"Cancel" forState:UIControlStateNormal];


        [UIView animateWithDuration:1.2 animations:^{
            self.createAccount.hidden = NO;
            self.logIn.hidden = YES;
            self.logInLabel.transform = CGAffineTransformMakeTranslation(0, -105);
            self.logInLabel.transform = CGAffineTransformMakeTranslation(0, -220);
            self.firstNameField.hidden = NO;
            self.lastNameField.hidden = NO;
            self.emailField.hidden = NO;
            self.firstNameField.alpha = 1;
            self.lastNameField.alpha = 1;
            self.emailField.alpha = 1;
            self.firstNameField.text = @"";
            self.lastNameField.text = @"";
            self.emailField.text = @"";
            self.userNameField.text = @"";
            self.passwordField.text = @"";


            sender.enabled = NO;
        } completion:^(BOOL finished) {
            sender.enabled = YES;

        }];
    } else {
        self.isSignIn = YES;
        [sender setTitle:@"Sign-Up" forState:UIControlStateNormal];

        [UIView animateWithDuration:1.2 animations:^{
            self.logInLabel.transform = CGAffineTransformMakeTranslation(0, -105);
            self.logInLabel.transform = CGAffineTransformMakeTranslation(0, 5);
            self.firstNameField.alpha = 0;
            self.lastNameField.alpha = 0;
            self.emailField.alpha = 0;
            self.createAccount.hidden = YES;
            self.logIn.hidden = NO;
            sender.enabled = NO;
            self.userNameField.text = @"";
            self.passwordField.text = @"";
        } completion:^(BOOL finished) {
            sender.enabled = YES;
            self.firstNameField.hidden = YES;
            self.lastNameField.hidden = YES;
            self.emailField.hidden = YES;
        }];
    }
}





- (IBAction)onLogInTapped:(UIButton *)sender
{

    if ([sender.titleLabel.text isEqualToString:@"Log In"]) {
        self.isSignIn = NO;
        [sender setTitle:@"Log In" forState:UIControlStateNormal];

        NSString  *username = self.userNameField.text;
        NSString *password = self.passwordField.text;

        [PFUser logInWithUsernameInBackground:username password:password
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                NSLog(@"User logged in");
                                            } else {
                                                NSLog(@"User can not log in");                                            }
                                        }];

    }


   }

-(IBAction)onCreateNewAccount:(UIButton *)sender {

    if ([sender.titleLabel.text isEqualToString:@"Create Account"]) {
        self.isSignIn = NO;

        PFUser *user = [PFUser user];
        user.username = self.userNameField.text;
        user.password = self.passwordField.text;
        user.email = self.emailField.text;
        //user[@"lastName"] = self.lastNameField.text;
        //user[@"firstName"] = self.firstNameField.text;


        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
            }else {
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                UIAlertView *signupError = [[UIAlertView alloc] initWithTitle:@"Opps!"
                                                                      message:[NSString stringWithFormat:@"Looks like we have a small issue: %@", errorString]
                                                                     delegate:self cancelButtonTitle:@"Continue"
                                                            otherButtonTitles:nil, nil];

                [signupError show];

            }
        }];
    }



    }






@end