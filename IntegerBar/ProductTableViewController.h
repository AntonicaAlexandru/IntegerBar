//
//  ProductTableViewController.h
//  IntegerBar
//
//  Created by Alexandru Antonica on 4/18/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) NSString *navTitle;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activInd;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
