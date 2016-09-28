//
//  LoginViewController.m
//  IntegerBar
//
//  Created by Vlad Nussem on 11/04/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "LoginViewController.h"

#import "UserModel.h"
#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface LoginViewController ()


@property (weak, nonatomic) IBOutlet UIButton *fbLoginBtn;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end


@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtEmail.delegate = self;
    self.txtPassword.delegate = self;
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginback"]];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    [self addBottomLineToTextField:self.txtEmail];
    [self addBottomLineToTextField:self.txtPassword];
    
    //tap gesture for removing keyboard when tapping somewhere else:
    UITapGestureRecognizer *tapRemoveKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    
    //setting placeholders and modifying textField border:
    _txtEmail.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"email" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"password" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    [self.view addGestureRecognizer:tapRemoveKeyboard];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.txtEmail.text = UserModel.instance.email;
    self.txtPassword.text = UserModel.instance.password;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideKeyboard{
    [_txtEmail resignFirstResponder];
    [_txtPassword resignFirstResponder];
}

- (void)addBottomLineToTextField:(UITextField *)textField{
    //adds a bottom border to a textField AND makes it transparent;
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height+8);
    border.borderWidth = borderWidth;
    [textField setBackgroundColor:[UIColor clearColor]];
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
}

- (IBAction)fbLoginBtnTochuUpInside:(id)sender {
    [UserModel.instance fbLogin];
}

- (IBAction)loginTouchUpInside:(id)sender {
    [UserModel.instance login];
}

#pragma mark userName & Passoword TextFields
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //if (textField.tag == 100) {
        [textField resignFirstResponder];
    //}
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        UserModel.instance.email = textField.text;
    } else if (textField.tag == 200) {
        UserModel.instance.password = textField.text;
    }
    return YES;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
