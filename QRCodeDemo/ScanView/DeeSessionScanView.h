//
//  DeeSessionScanView.h
//  QRCodeDemo
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^scannerResultCallback)( NSString * _Nullable result);

//session 配置展示类
@interface DeeSessionScanView : UIView

/**
开启或关闭闪光灯

@param on 开启或关闭
@param callback 成功回调
*/
- (void)setTorchOn:(BOOL)on openSuccess:(void(^_Nullable)(BOOL success))callback;

/**
 是否自动检测光线
 
 @param isDective 自动检测光线
 */
- (void)AutoDectecBrightness:(BOOL)isDective;


/**
 开始扫描
 
 @param resultblock 结果回调
 */
- (void)startScannerWithResult:(nullable scannerResultCallback)resultblock;

/**
 停止扫描
 */
- (void)stopScanner;

/**
 设置扫描区域
 */
- (void)setScanArea:(CGRect)rect;

/**
 获取扫描区域
 如果获取了扫描的区域那么就会有返回值
 */
- (CGRect)getScanRect;

@end
