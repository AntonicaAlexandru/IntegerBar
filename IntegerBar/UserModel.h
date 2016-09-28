//
//  UserModel.h
//  IntegerBar
//
//  Created by Vlad Nussem on 30/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModelViewControllerProtocol.h"

@interface UserModel : NSObject

+ (instancetype)instance;

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *authorizationToken;
@property (nonatomic, strong) NSString *fbToken;


@property (nonatomic, strong) id <UserModelViewControllerProtocol> viewControllerDelegate;

- (void)signup;
- (void)editProfile;
- (void)getProfileInformation;
- (void)login;
- (void)fbLogin : (BOOL)refreshToken completion:(void (^)(BOOL finished))completion;
- (void)fbLogin;
- (void)logout;
- (NSDictionary *) userInformation;

- (void)restoreLogin;

- (void)onSignupSuccess : (NSDictionary *) response;
- (void)onEditProfileSuccess : (NSDictionary *) response;
- (void)onGetProfileInformationSuccess : (NSDictionary *) response;
- (void)onLoginSuccess : (NSDictionary *) response;
- (void)onLogoutSuccess : (NSDictionary *) response;

@end
