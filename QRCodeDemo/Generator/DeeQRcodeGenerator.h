//
//  DeeQRcodeGenerator.h
//  QRCodeDemo
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 Dee. All rights reserved.
//
// 二维码生成器
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DeeQRcodeGenerator : NSObject

/**
 根据text 生成 二维码

 @param text 文本内容
 @param size 图片尺寸
 @return 图片
 */
+ (UIImage *)generatorQRCodeWithString:(NSString *)text size:(CGFloat)size;



/**
 根据URL 生成 二维码

 @param url URL
 @param size 图片尺寸
 @return 图片
 */
+ (UIImage *)generatorQRCodeWithURL:(NSURL *)url size:(CGFloat)size;
@end
