//
//  ViewController.m
//  QRCodeDemo
//
//  Created by Dee on 2018/3/20.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import "ViewController.h"
#import "DeeScannerViewController.h"

@interface ViewController ()


@end

@implementation ViewController
- (IBAction)StartAction:(id)sender {
    DeeScannerViewController *vc = [[DeeScannerViewController alloc] init];
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}





@end
