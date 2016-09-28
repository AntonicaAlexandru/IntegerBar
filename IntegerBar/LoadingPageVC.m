//
//  LoadingPageVC.m
//  IntegerBar
//
//  Created by Vlad Nussem on 17/05/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "LoadingPageVC.h"
#import "MBProgressHUD.h"

@interface LoadingPageVC ()

@end

@implementation LoadingPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginbackwhite"]];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    [MBProgressHUD showHUDAddedTo:((UIViewController *)(self)).view animated:YES];  // Show spinner while loading content.
    
    
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
