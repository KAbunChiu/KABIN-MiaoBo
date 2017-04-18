//
//  KABINTool.h
//  RuleBaby
//
//  Created by KAbun on 16/11/1.
//  Copyright © 2016年 KABin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KABINTool : NSObject
#pragma mark - HUD
/// 显示提示信息
+ (void)showMsg:(NSString *)message;
/// 显示成功
+ (void)showSuccessWithStatus:(NSString *)status;
/// 显示错误
+ (void)showErrorWithStatus:(NSString*)status;
/// 显示图片和文字
+ (void)showImage:(UIImage*)image status:(NSString*)status;
/// 显示加载中...
+ (void)showLoading;

+ (void)showLoading:(NSString *)message;

/// 隐藏所有指示器
+ (void)hideHUD;

#pragma mark -
///检测手机号码是否合法
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
///检测邮箱是否合法
+(BOOL)isValidateEmail:(NSString *)email;
#pragma mark - 动画

@end
