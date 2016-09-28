//
//  NewsFeedController.m
//  IntegerBar
//
//  Created by Mihai Honceriu on 22/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "NewsFeedController.h"
#import "FeedCell.h"
#import "SWRevealViewController.h"
#import "CoreDataFetcher.h"
#import "tab.h"

@interface NewsFeedController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *cardSizeArray;
}

@end

@implementation NewsFeedController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"News";
    self.feedTableView.delegate = self;
    /*if([self.navigationController.parentViewController isKindOfClass:[UITabBarController class]]){
        self.navigationController.navigationBar.hidden = YES;
    }*/
    self.feedTableView.dataSource = self;
    self.feedTableView.separatorColor = [UIColor clearColor];
    self.feedTableView.estimatedRowHeight = 40;
    self.feedTableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCellid"];
    if (cell == nil)
        cell = [[FeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"feedCellid"];
    if(indexPath.section == 0){
        cell.titleLabel.text = @"//integerBar Hackathon 2016";
        cell.dateLabel.text = @"5 June 2016";
    cell.descriptionLabel.text = @"Although most of you come to //integerBar to relax with friends, we invite you for a different kind of experience next monday! \n \n We all know the meaning of a hackathon, that's for sure, but do we all have what it takes to succesfuly make it through one? We're proud to present you our next project which will be held in our bar - the //integerBar Hackathon !  \n \n - Mihai";
    }
    if(indexPath.section == 1){
        cell.titleLabel.text = @"Open bar next saturday!";
        cell.dateLabel.text = @"21 May 2016";
        cell.descriptionLabel.text = @"Come drink a beer with us next saturday. \n \n We will have open bar for all the programmers working in the building. \n \n  See you there! \n";
    }
    if(indexPath.section == 2){
        cell.titleLabel.text = @"integerBar is now OPEN!";
        cell.dateLabel.text = @"5 May 2016";
        cell.descriptionLabel.text = @"We are happy to announce that integerBar is now open! \n \n We hope you will have a great time in our restaurant. \n \n - integerBar team";
    }
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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
