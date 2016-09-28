//
//  UserProfileVC.h
//  IntegerBar
//
//  Created by Vlad Nussem on 03/05/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModelViewControllerProtocol.h"

@interface UserProfileVC : UIViewController <UserModelViewControllerProtocol, UITableViewDelegate, UITableViewDataSource>

@end
