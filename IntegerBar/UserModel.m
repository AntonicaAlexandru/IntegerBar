//
//  UserModel.m
//  IntegerBar
//
//  Created by Vlad Nussem on 30/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "UserModel.h"
#import "HttpRequest.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "AppDelegate.h"


static NSString *signupURL      = @"https://private-e95dd3-integerbar.apiary-mock.com/api/v1/accounts";
static NSString *editProfileURL = @"https://private-e95dd3-integerbar.apiary-mock.com/api/v1/accounts";
static NSString *getProfileInformationURL = @"https://private-e95dd3-integerbar.apiary-mock.com/api/v1/accounts";
static NSString *loginURL = @"https://private-e95dd3-integerbar.apiary-mock.com/api/v1/sessions";
//static NSString *logoutURL = @"https://private-anon-9dcc0b69d-integerbar.apiary-mock.com/api/v1/sessions";
static NSString *logoutURL = @"http://private-255ff-integerbar.apiary-mock.com/api/v1/sessions";
static NSString *kEmail = @"email";
static NSString *kPassword = @"password";
static NSString *kSavedUserCredentials = @"credentials";



@implementation UserModel

+ (instancetype)instance
{
    static UserModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserModel alloc] init];
        [instance restoreLogin];
        
    });
    return instance;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _email = [aDecoder decodeObjectForKey:kEmail];
        _password = [aDecoder decodeObjectForKey:kPassword];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_email forKey:kEmail];
    [coder encodeObject:_password forKey:kPassword];
    
}

- (void)restoreLogin {
    
    // Try Restore fbLogin
    [self fbLogin:true completion:^(BOOL finished) {
        if (!self.fbToken) {
            
            //Try Restore email&password
            [self restoreEmailAndPassordLogin];
            
            UIStoryboard *tabBarSB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            UIViewController *tabBarVC = [tabBarSB instantiateViewControllerWithIdentifier:@"LoginId"];
            [appDelegate.window setRootViewController:tabBarVC];
        }
    }];
    
}

- (void)restoreEmailAndPassordLogin {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    id savedUserCredentials = [userDefaults objectForKey:kSavedUserCredentials];
    if (savedUserCredentials) {
        NSArray *savedArray = [NSKeyedUnarchiver unarchiveObjectWithData: savedUserCredentials];
        UserModel *user = [savedArray firstObject];
        self.email = user.email;
        self.password = user.password;
        [self login];
    }
}

- (void)signup {
    NSDictionary *params = @ {
            @"provider": @"email"
          , @"user": [self userJSON]
    };
    
    //[self postWithURL : signupURL andParams: params authorization : nil callback:@"onSignupSuccess:"];
    [HttpRequest.instance postWithURL : signupURL andParams: params authorization : nil callback:@"onSignupSuccess:" delegate : self];
    
}

- (void)editProfile {
    
    NSDictionary *params = @ {
            @"user": [self userJSON]
    };
    
    //[self postWithURL : editProfileURL andParams: params authorization : self.authorizationToken callback:@"onEditProfileSuccess:"];
    [HttpRequest.instance postWithURL : editProfileURL andParams: params authorization : self.authorizationToken callback:@"onEditProfileSuccess:" delegate : self];
}

- (void)getProfileInformation {
    
    NSDictionary *params = nil;
    
    //[self getWithURL : getProfileInformationURL andParams: params authorization : self.authorizationToken callback:@"onGetProfileInformationSuccess:"];
    [HttpRequest.instance  getWithURL : getProfileInformationURL andParams: params authorization : self.authorizationToken callback:@"onGetProfileInformationSuccess:" delegate : self];
}

- (void)logout {
    
    NSDictionary *params = nil;
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    //[HttpRequest.instance  getWithURL : logoutURL andParams: params authorization : self.authorizationToken callback:@"onLogoutSuccess:" delegate : self];
    [HttpRequest.instance postWithURL : logoutURL andParams: params authorization : nil callback:@"onLogoutSuccess:" delegate : self];
}

- (void)login {
    
    if (self.email && self.password) {
        NSDictionary *params = @ {
            @"provider": @"email"
            , @"user": [self userJSON]
        };
    
    
        //[self postWithURL : loginURL andParams: params authorization : nil callback:@"onLoginSuccess:"];
        [HttpRequest.instance postWithURL : loginURL andParams: params authorization : nil callback:@"onLoginSuccess:" delegate : self];
    }
}

- (void)fbLogin {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    //login.loginBehavior = FBSDKLoginBehaviorNative;
    [login
     logInWithReadPermissions: @[@"public_profile"]
     //fromViewController:self
     fromViewController:nil
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             [self fbLogin : false completion:nil];
         }
     }];
    
    
}

- (void)fbLogin : (BOOL)refreshToken completion:(void (^)(BOOL finished))completion {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        if (refreshToken) {
            [FBSDKAccessToken refreshCurrentAccessToken:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                [self setFbTokenString];
                completion(YES);
                }
             ];
        }
        else {
            [self setFbTokenString];
            if (completion) {
                completion(YES);
            }
        }
    }
    else {
        if (completion) {
            completion(YES);
        }
    }
    
}

- (void)setFbTokenString {
    self.fbToken = [FBSDKAccessToken currentAccessToken].tokenString;
    if (self.fbToken) {
        NSDictionary *user = @ {
            @"access_token_version": @"oauthv2",
        //@"access_token": @"kjashdjashdkjsahaksjs21767yahjkhsakjashsa"
            @"access_token": self.fbToken
        };
    
        NSDictionary *params = @ {
            @"provider": @"facebook"
        ,   @"user": user
        };
    
        //[self postWithURL : loginURL andParams: params authorization : nil callback:@"onLoginSuccess:"];
        [HttpRequest.instance postWithURL : loginURL andParams: params authorization : nil callback:@"onLoginSuccess:" delegate : self];
    }
}





#pragma Requests Success
- (void)onSignupSuccess : (NSDictionary *) response {
    NSLog(@"Signup Success!");
    self.authorizationToken = (NSString *)[response objectForKey: @"authorization_token"];
    NSLog(@"AuthorizationToken: %@", self.authorizationToken);
}

- (void)onEditProfileSuccess : (NSDictionary *) response {
    NSLog(@"EditProfile Success!");
}

- (void)onGetProfileInformationSuccess : (NSDictionary *) response {
    NSLog(@"Get Profile Information Success!");
    
    response = [response objectForKey:@"user"];
    
    self.firstName = [response objectForKey:@"firstname"];
    self.lastName = [response objectForKey:@"lastname"];
    self.email = [response objectForKey:@"email"];
    self.phoneNumber = [response objectForKey:@"phone"];
    
    if (self.viewControllerDelegate) {
        [self.viewControllerDelegate onGetUserProfileSuccess];
    }
}

- (void)onLoginSuccess : (NSDictionary *) response {
    self.authorizationToken = (NSString *)[response objectForKey: @"authorization_token"];
    
    //NSLog(@"Login Success!");
    //NSLog(@"%@", response);
    
    self.firstName = [response objectForKey:@"name"];
    
    //Persist user Credentials
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [[NSArray alloc] initWithObjects:self, nil];
    [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:array] forKey:kSavedUserCredentials];
    
    UIStoryboard *tabBarSB = [UIStoryboard storyboardWithName:@"TabBarMenu" bundle:nil];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    UIViewController *tabBarVC = [tabBarSB instantiateViewControllerWithIdentifier:@"TabBarID"];
    [appDelegate.window setRootViewController:tabBarVC];
}

- (void)onLogoutSuccess : (NSDictionary *) response {
    NSLog(@"Logout Success!");
    NSLog(@"%@", response);
    
    UIStoryboard *tabBarSB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    UIViewController *tabBarVC = [tabBarSB instantiateViewControllerWithIdentifier:@"LoginId"];
    [appDelegate.window setRootViewController:tabBarVC];
    
}

- (NSDictionary *) userJSON {
    NSDictionary *user = @ {
        @"phone"        : self.phoneNumber ? self.phoneNumber : @""
        , @"firstName"  : self.firstName ? self.firstName : @""
        , @"lastname"   : self.lastName ? self.lastName : @""
        , @"email"      : self.email 
        , @"password"   : self.password
    };
    return user;
}

- (NSDictionary *) userInformation {
    NSDictionary *user = @ {
          @"First Name"  : self.firstName ? self.firstName : @""
        , @"Last Name"   : self.lastName ? self.lastName : @""
        , @"Phone Number"        : self.phoneNumber ? self.phoneNumber : @""
        , @"Email"      : self.email ? self.email : @""
    };
    return user;
}


@end

