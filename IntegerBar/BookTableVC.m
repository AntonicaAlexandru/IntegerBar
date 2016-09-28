//
//  BookTableVC.m
//  IntegerBar
//
//  Created by Vlad Nussem on 17/05/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "BookTableVC.h"

@interface BookTableVC ()



@end

static NSString *phoneNumber = @"0744339878";

@implementation BookTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Book table";
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"booktable-1"]];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bookNowTouchUpInside:(id)sender {
    NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@",phoneNumber];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:[NSString stringWithFormat:@"You are about to call %@ .",phoneStr]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
                                                         [[UIApplication sharedApplication] openURL:phoneURL];
                                                     }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
    
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    //[phoneURL release];
    //[phoneStr release];
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
