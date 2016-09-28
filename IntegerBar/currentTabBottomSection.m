//
//  currentTabBottomSection.m
//  IntegerBar
//
//  Created by Mihai Honceriu on 05/04/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "currentTabBottomSection.h"
#import "QRViewController.h"
#import "tab.h"
@interface currentTabBottomSection (){
    QRCodeReaderViewController *vc;
}
@end
@implementation currentTabBottomSection

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)confirmButtonPressed:(id)sender {
    if(_delegate.tableNumber == 0){
    // Create the reader object
    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // Instantiate the view controller
    vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
    
    // Set the presentation style
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
        /*UILabel *qrCodeScannerText = [[UILabel alloc] init];
        qrCodeScannerText.text =  @"Please scan the QR code on the table so we know where to bring the stuff:)";
        [vc.view addSubview:qrCodeScannerText];*/
    // Define the delegate receiver
    vc.delegate = self.delegate;
        
    [self.delegate presentViewController:vc animated:YES completion:NULL];
    }
    if(_delegate.tableNumber !=0 )
        [[tab currentTab] orderProducts];

   // [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshCurrentTab" object:nil];
}
- (IBAction)payButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure?"
                                                                   message:@"Paying the products will end the current tab"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         [[tab currentTab] payProducts];
                                                     }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
    
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self.delegate presentViewController:alert animated:YES completion:nil];
}
@end
