//
//  DeeQRcodeGenerator.m
//  QRCodeDemo
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import "DeeQRcodeGenerator.h"
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>
#import "UIImage+generator.h"
@interface DeeQRcodeGenerator()

@end

@implementation DeeQRcodeGenerator

+ (UIImage *)generatorQRCodeWithString:(NSString *)text size:(CGFloat)size {
    //过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //初始化默认是设置
    [filter setDefaults];
    NSData *data = [text dataUsingEncoding: NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    return [UIImage generatorImageWithCIImage:outputImage withSpecificSize:size];
}

+ (UIImage *)generatorQRCodeWithURL:(NSURL *)url size:(CGFloat)size {
    NSString *str = [url absoluteString];
    return [self generatorQRCodeWithString:str size:size];
}



@end
