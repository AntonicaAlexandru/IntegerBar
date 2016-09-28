//
//  OrderTableViewController.m
//  IntegerBar
//
//  Created by Alexandru Antonica on 3/24/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "OrderTableViewController.h"
#import "CustomHeaderTableViewCell.h"
#import "CustomCategoryTableViewCell.h"
#import "ProductTableViewController.h"
#import "AFHTTPSessionManager.h"
#import "CoreDataFetcher.h"
#import "GeneralResultsTableViewController.h"


@interface OrderTableViewController (){
    NSMutableArray      *expandedCategories;
    NSString            *categorySelected;
    NSMutableDictionary *subCateg;
    UILabel             *messageLabel;
    NSArray             *categories;
    NSMutableDictionary *categDict;
}
@end

@implementation OrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    expandedCategories = [[NSMutableArray alloc] init];

    self.title = @"Order";
    
    if ([categories count] == 0)
        categories = @[@"Food", @"Drinks", @"Desserts", @"Offers"];

    
    for (id x __unused in categories) {
        [expandedCategories addObject:[NSNumber numberWithBool:NO]];
    }

    if (categDict == nil)
        categDict = [[NSMutableDictionary alloc] init];
    
    
    /*Load whatever is in the DB*/
    [self downloadDone:nil];
    

    
    self.refreshControl                 = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor grayColor];
    self.refreshControl.tintColor       = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshData)
                  forControlEvents:UIControlEventValueChanged];
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [categories count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if ([expandedCategories count] > 0) {
        if ([expandedCategories[section] boolValue]){
            NSSet *subs = [categDict objectForKey:categories[section]];
            return [subs count]+1;
        }
             
        return 1;
    }

    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if ( indexPath.row == 0) {
        
        CustomHeaderTableViewCell *myCell = (CustomHeaderTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"customHeader"];
    
    
    if (myCell == nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"CustomHeaderTableViewCell" owner:self options:nil];
        myCell = [nibArray objectAtIndex:0];
    }
    

        NSString *str = categories[indexPath.section];
        myCell.categoryIV.image = [UIImage imageNamed:str];
        myCell.titleLB.text     = str;
       
        
        if ([expandedCategories[indexPath.section] boolValue]) {
            myCell.fakeIV.hidden = YES;
        }else{
            myCell.fakeIV.hidden = NO;
        }
        
        return myCell;
            
    }else{
        
        CustomCategoryTableViewCell *myCategoryCell = (CustomCategoryTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"customCategoryCellIdentifier"];
        
        if (myCategoryCell == nil) {
            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"CustomCategoryTableViewCell" owner:self options:nil];
            myCategoryCell = [nibArray objectAtIndex:0];
        }
        
        
        NSSet *subs = [categDict objectForKey:categories[indexPath.section]];
        myCategoryCell.categoryTitle.text = [subs allObjects][indexPath.row-1];
        
        return myCategoryCell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 157.5;
    }
    
    return 52;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ( indexPath.row == 0) {
        
        //Make all numbers FALSE
        for (int i = 0; i < [categories count]; i++) {
            if (i != indexPath.section) {
                [expandedCategories replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
            }
        }
        
        if ([expandedCategories[indexPath.section] boolValue]) {
            [expandedCategories replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:NO]];
        }else{
            [expandedCategories replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:YES]];
        }
        
        [self.tableView beginUpdates];
        for (int i = 0; i < [categories count]; i++) {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:i] withRowAnimation:UITableViewRowAnimationFade];
        }
        [self.tableView endUpdates];
        
        [self.tableView scrollToRowAtIndexPath:indexPath
                         atScrollPosition: UITableViewScrollPositionMiddle animated:YES];
        
    }
    
    else{
        
        categorySelected = ((CustomCategoryTableViewCell*)[tableView  cellForRowAtIndexPath:indexPath]).categoryTitle.text;
        ProductTableViewController *prdVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ProductTableViewController class])];
        
        prdVC.navTitle = categorySelected;
        [self.navigationController pushViewController:prdVC animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ProductTableViewController *prdTVC = [segue destinationViewController];
    prdTVC.navTitle = categorySelected;
    
}


#pragma mark - My Methods
/*
    In this method we send a request to the server to find out what
 categories we need and what subcategories exists for each major category

 E.g. major category: food,drinks
       subcategory for Food: pasta, pizza etc.
 */
-(void) downloadDone:(NSNotification*)notification{
    
    if ([categories count] == 0) {
        categories = @[@"Food", @"Drinks", @"Desserts", @"Offers"];
    }
    
    if (categDict == nil) {
        categDict  = [[NSMutableDictionary alloc] init];
    }
    
    for (NSString *category in categories) {
        NSSet *array = [CoreDataFetcher getSubCategories:category];
        [categDict setObject:array forKey:category];
    }
    
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
    
}

-(void) refreshData{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate loadProductsDB];
    
}

-(void) downloadFail:(NSNotification*)notification{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Updating Failed"
                                  message:@"Check your internet connection or try to reload!"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];

    
    [alert addAction:ok];
    
    [self.refreshControl endRefreshing];
    [self presentViewController:alert animated:YES completion:nil];

    
    
    
}

- (IBAction)navSearchBar:(UIBarButtonItem *)sender {
    
    GeneralResultsTableViewController *tableVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([GeneralResultsTableViewController class])];
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController: tableVC];

    searchController.delegate = tableVC;
    [self presentViewController:searchController animated:YES completion:nil];
    
}





@end
