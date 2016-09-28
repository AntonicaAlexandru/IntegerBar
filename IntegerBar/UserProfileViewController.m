//
//  UserProfileViewController.m
//  IntegerBar
//
//  Created by Vlad Nussem on 30/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserModel.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface UserProfileViewController ()

@property (nonatomic, strong) UserModel *user;

@end

@implementation UserProfileViewController


- (UserModel *)user {
    if (!_user) {
        _user = [[UserModel alloc] init];
    }
    return _user;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /*
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
         }
     }];
     */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    self.user.phoneNumber = @"727 828 868";
    self.user.firstName = @"Vlad";
    self.user.lastName = @"Nussem";
    self.user.email = @"Vladimir.Nussem@devpadawan.ro";
    self.user.password = @"psw";
    
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
    [FBSDKAccessToken currentAccessToken];
     */
}

/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signup:(id)sender {
    [self.user signup];
}
- (IBAction)editProfile:(id)sender {
    [self.user editProfile];
}
- (IBAction)getProfileInformation:(id)sender {
    [self.user getProfileInformation];
}
- (IBAction)login:(id)sender {
    [self.user login];
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
