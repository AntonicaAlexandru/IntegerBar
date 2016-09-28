//
//  TabBarController.m
//  IntegerBar
//
//  Created by Mihai Honceriu on 21/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "TabBarController.h"
#import "product.h"
#import "CoreDataFetcher.h"
#import "tab.h"
#import "AppDelegate.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeTabBarDesign];
    [self initializeTabBarScreens];
    
}


- (void)initializeTabBarDesign{
    //Setting the TabBars colors, item titles and images;
    UITabBarItem *feed,*currentTab,*profile,*book,*order;
    [self.tabBar setTintColor:[UIColor colorWithRed:0 green:(64/255.0) blue:(128/255.0) alpha:1]];
    [self.tabBar setBarTintColor:[UIColor whiteColor]];
    [self.tabBar setTranslucent:true];
    feed = [self.tabBar.items objectAtIndex:0]; [feed setTitle:@"News"];
    book = [self.tabBar.items objectAtIndex:1]; [book setTitle:@"Book table"];
    order = [self.tabBar.items objectAtIndex:2]; [order setTitle:@"Order"];
    currentTab = [self.tabBar.items objectAtIndex:3]; [currentTab setTitle:@"Current Tab"];
    profile = [self.tabBar.items objectAtIndex:4]; [profile setTitle:@"Profile"];
    [[tab currentTab] addProduct:[CoreDataFetcher getProductWithPrediate:[NSPredicate predicateWithFormat:@"productID = %@", @"1"]][0]];
    [[tab currentTab] addProduct:[CoreDataFetcher getProductWithPrediate:[NSPredicate predicateWithFormat:@"productID = %@", @"2"]][0]];
    feed.image = [UIImage imageNamed:@"home-32"];
    feed.selectedImage = [UIImage imageNamed:@"home_filled-32"];
    book.image = [UIImage imageNamed:@"table-32"];
    book.selectedImage = [UIImage imageNamed:@"table_filled-32"];
    order.image = [UIImage imageNamed:@"dining_room-32"];
    order.selectedImage = [UIImage imageNamed:@"dining_room_filled-32"];
    currentTab.image = [UIImage imageNamed:@"agreement-32"];
    currentTab.selectedImage = [UIImage imageNamed:@"agreement_filled-32"];
    profile.image = [UIImage imageNamed:@"gender_neutral_user-32"];
    profile.selectedImage = [UIImage imageNamed:@"gender_neutral_user_filled-32"];
}

- (void)initializeTabBarScreens{
    //Setting the tab bar pages from other storyboards;
    UIStoryboard *newsFeedSB = [UIStoryboard storyboardWithName:@"NewsFeed" bundle:nil];
    UIStoryboard *currentTabSB = [UIStoryboard storyboardWithName:@"CurrentTab" bundle:nil];
    UIStoryboard *orderTabSB = [UIStoryboard storyboardWithName:@"OrderStoryboard" bundle:nil];
    UINavigationController *orderTabNav = [self.viewControllers objectAtIndex:2];
    UINavigationController *newsFeedNav = [self.viewControllers objectAtIndex:0];
    UINavigationController *currentTabNav = [self.viewControllers objectAtIndex:3];
    UINavigationController *orderTabVC = [orderTabSB instantiateViewControllerWithIdentifier:@"orderTabVC"];
    UIViewController *newsFeedVC = [newsFeedSB instantiateViewControllerWithIdentifier:@"newsFeedVC"];
    UIViewController *tabBarVC = [currentTabSB instantiateViewControllerWithIdentifier:@"currentTabVC"];
    
    [[NSNotificationCenter defaultCenter] addObserver:orderTabVC.viewControllers[0] selector:@selector(downloadDone:)  name:@"UpdateDone" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:orderTabVC.viewControllers[0] selector:@selector(downloadFail:)  name:@"UpdateFail" object:nil];
    
    [orderTabNav setViewControllers: @[orderTabVC.viewControllers[0]] animated:NO];
    [newsFeedNav setViewControllers:@[newsFeedVC] animated:NO];
    [currentTabNav setViewControllers:@[tabBarVC] animated:NO];
    
    // User Profile
    //UIStoryboard *userProfileSB = [UIStoryboard storyboardWithName:@"UserProfile" bundle:nil];
    UIStoryboard *userProfileSB = [UIStoryboard storyboardWithName:@"UserProfileTable" bundle:nil];
    UINavigationController *userProfileNav = [self.viewControllers objectAtIndex:4];
    UIViewController *userProfileVC = [userProfileSB instantiateViewControllerWithIdentifier:@"UserProfileVC"];
    [userProfileNav setViewControllers:@[userProfileVC] animated:NO];
    
    // Book Table
    UIStoryboard *bookTableSB = [UIStoryboard storyboardWithName:@"BookTable" bundle:nil];
    UINavigationController *bookTableNav = [self.viewControllers objectAtIndex:1];
    UIViewController *bookTableVC = [bookTableSB instantiateViewControllerWithIdentifier:@"BookTableVC"];
    [bookTableNav setViewControllers:@[bookTableVC] animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
