//
//  UIImage+detect.h
//  QRCodeDemo
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (detect)

/**
 检测图片二维码检测

 @param ciimage CIImage
 @param callback 数据回调
 */
+ (void)detectQRCodeWithCIImage:(CIImage *)ciimage withCallBack:(void(^)(NSArray *infos))callback;


/**
 检测图片二维码

 @param image UIImage
 @param callback 回调
 */
+ (void)detectQRCodeWithImage:(UIImage *)image withCallBack:(void (^)(NSArray *infos))callback;

@end
