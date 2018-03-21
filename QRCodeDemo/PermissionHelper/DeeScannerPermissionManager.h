//
//  DeeScannerPermissionManager.h
//  QRCodeDemo
//
//  Created by Dee on 2018/3/20.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,k_CurrentAuthorizedStatus) {
    k_CurrentAuthorizedStatus_NotDetermind,
    k_CurrentAuthorizedStatus_Restricted,
    k_CurrentAuthorizedStatus_Denied,
    k_CurrentAuthorizedStatus_Authrized,
};

typedef void(^authorizedStatusCallback)(k_CurrentAuthorizedStatus);
typedef void(^getPermissionCallback)(BOOL isGranted);

//help to manager the permission and status
@interface DeeScannerPermissionManager : NSObject

//to get authorized Permission
- (void)getAudioPermissionWithCallBack:(getPermissionCallback)bloc;

//to get authorized Permission status
- (void)checkoutAuthorizationStatusWithCallBackWithblock:(authorizedStatusCallback)block;
@end
