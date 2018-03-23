//
//  DeeScannerViewController.m
//  QRCodeDemo
//
//  Created by Dee on 2018/3/20.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import "DeeScannerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DeeScannerLayer.h"
#import "DeeQRCodeDemoLayer.h"
@interface DeeScannerViewController ()

@end

@implementation DeeScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
    
//    DeeSessionScanView  *view = [[DeeSessionScanView alloc] initWithFrame:self.view.frame];
//    [self.view.layer addSublayer:view.layer];
//    [view setScanArea:CGRectMake(100, 100, 100, 100)];
//    [view AutoDectecBrightness:YES];
//    [view startScannerWithResult:^(NSString *result) {
//        NSLog(@"%@",result);
//    }];
    
    DeeScannerLayer *scanLayer = [[DeeScannerLayer alloc] initWithLayerFrame:self.view.frame];
    [self.view.layer addSublayer:scanLayer];
    [scanLayer setScanArea:CGRectMake(100, 100, 100, 100)];
    [scanLayer startScannerWithResult:^(NSString * _Nullable result) {
        NSLog(@"%@",result);
    }];
    
    DeeQRCodeDemoLayer *layer = [[DeeQRCodeDemoLayer alloc] initWithFrame:self.view.frame
                                                                ClearRect:CGRectMake(100, 100, 100, 100)];
    [self.view.layer addSublayer:layer];
    [layer setNeedsDisplay];
    
    
}
@end
