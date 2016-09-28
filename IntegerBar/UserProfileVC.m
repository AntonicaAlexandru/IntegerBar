//
//  UserProfileVC.m
//  IntegerBar
//
//  Created by Vlad Nussem on 03/05/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "UserProfileVC.h"
#import "UserModel.h"
#import "MBProgressHUD.h"
#import "UserModel.h"


@interface UserProfileVC ()

/*
@property (weak, nonatomic) IBOutlet UILabel *lblFirstName;
@property (weak, nonatomic) IBOutlet UILabel *lblLastName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;
*/

@property (weak, nonatomic) IBOutlet UITableView *userProfileTableView;

@end

@implementation UserProfileVC 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Profile";
    self.userProfileTableView.delegate = self;
    self.userProfileTableView.dataSource = self;
    self.userProfileTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    MBProgressHUD *progressHud = [MBProgressHUD showHUDAddedTo:((UIViewController *)(self)).view animated:YES];  // Show spinner while loading content.
    progressHud.labelText = @"Loading data";
    /*
    self.lblFirstName.text   = @"";
    self.lblLastName.text    = @"";
    self.lblEmail.text       = @"";
    self.lblPhoneNumber.text = @"";
     */
    self.userProfileTableView.hidden = YES;
    
    UserModel.instance.viewControllerDelegate = self;
    
    [UserModel.instance getProfileInformation];
    
}

- (void)onGetUserProfileSuccess {
    /*
    self.lblFirstName.text   = UserModel.instance.firstName;
    self.lblLastName.text    = UserModel.instance.lastName;
    self.lblEmail.text       = UserModel.instance.email;
    self.lblPhoneNumber.text = UserModel.instance.phoneNumber;
    */
     
    [MBProgressHUD hideHUDForView:((UIViewController *)(self)).view animated:YES];  // Dismiss spinner.
    
    [self.userProfileTableView reloadData];
    
    self.userProfileTableView.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutTouchUpInside:(id)sender {
    NSLog(@"Logout");
    [UserModel.instance logout];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
    return UserModel.instance.userInformation ? UserModel.instance.userInformation.allKeys.count : 0;
    else
        return UserModel.instance.userInformation ? 1 : 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @" ";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
        UILabel *label = (UILabel *)[cell viewWithTag:100];
        label.text = [NSString stringWithFormat:@"%@:",[[UserModel.instance.userInformation allKeys] objectAtIndex:indexPath.row]];
    
        UILabel *value = (UILabel *)[cell viewWithTag:200];
        value.text = [UserModel.instance.userInformation objectForKey:[NSString stringWithFormat:@"%@",[[UserModel.instance.userInformation allKeys] objectAtIndex:indexPath.row]]];
    
    }
    if(indexPath.section==1) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"logoutCell" forIndexPath:indexPath];
    }
    return cell;
    
}


 
@end
