//
//  CurrentTabVC.h
//  IntegerBar
//
//  Created by Mihai Honceriu on 29/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderViewController.h"

@protocol CurrentTabVCDelegate <NSObject>

-(void)refreshCurrentTabProducts;

@end

@interface CurrentTabVC : UIViewController <UITableViewDataSource , UITableViewDelegate, CurrentTabVCDelegate, QRCodeReaderDelegate>
@property (weak, nonatomic) IBOutlet UITableView *currentTabTable;
@property (nonatomic) NSInteger tableNumber;

@end
