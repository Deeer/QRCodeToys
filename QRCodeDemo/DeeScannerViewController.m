//
//  DeeScannerViewController.m
//  QRCodeDemo
//
//  Created by Dee on 2018/3/20.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import "DeeScannerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DeeSessionScanView.h"

@interface DeeScannerViewController ()

@end

@implementation DeeScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
    DeeSessionScanView  *view = [[DeeSessionScanView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
    [view AutoDectecBrightness:YES];
    [view startScannerWithResult:^(NSString *result) {
        NSLog(@"%@",result);
    }];
}
@end
