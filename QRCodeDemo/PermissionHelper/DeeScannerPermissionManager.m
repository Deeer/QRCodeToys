//
//  DeeScannerPermissionManager.m
//  QRCodeDemo
//
//  Created by Dee on 2018/3/20.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import "DeeScannerPermissionManager.h"
#import <AVFoundation/AVFoundation.h>

@interface DeeScannerPermissionManager()

@end

@implementation DeeScannerPermissionManager

//to get permission form systerm
- (void)getAudioPermissionWithCallBack:(getPermissionCallback)block {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        if (block) {
            block(granted);
        }
    }];
}

//check out the permission status
- (void)checkoutAuthorizationStatusWithCallBackWithblock:(authorizedStatusCallback)block {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (block) {
        block((k_CurrentAuthorizedStatus) status);
    }
}

@end
