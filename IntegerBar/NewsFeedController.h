//
//  NewsFeedController.h
//  IntegerBar
//
//  Created by Mihai Honceriu on 22/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsFeedController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@end
