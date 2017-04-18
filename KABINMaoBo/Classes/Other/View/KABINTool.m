//
//  KABINTool.m
//  RuleBaby
//
//  Created by KAbun on 16/11/1.
//  Copyright © 2016年 KABin. All rights reserved.
//

#import "KABINTool.h"
#import "MBProgressHUD.h"
#import <SVProgressHUD.h>

#define APP [UIApplication sharedApplication]

@implementation KABINTool

#pragma mark - HUD

+ (MBProgressHUD *)Hud
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:APP.keyWindow];
    if (hud){
        [hud removeFromSuperview];
    }else{
        hud = [[MBProgressHUD alloc] initWithView:APP.keyWindow];
        hud.removeFromSuperViewOnHide = YES;
    }
    [APP.keyWindow addSubview:hud];
    return hud;
}

#pragma mark - 设置SVP的默认属性
+ (void) initSVProgressHUD
{
    [SVProgressHUD setViewForExtension:APP.keyWindow];
    [SVProgressHUD setCornerRadius:5];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:KColor(2, 130, 240)];
}

#pragma mark - 显示纯文字的提示框
+ (void)showMsg:(NSString *)message
{
    
    //    MBProgressHUD *hud = [self Hud];
    //    hud.label.text = message;
    //    hud.mode = MBProgressHUDModeText;
    //    hud.label.font = [UIFont systemFontOfSize:13];
    //    [hud showAnimated:YES];
    //    [hud hideAnimated:YES afterDelay:1.0];
    //    [SVProgressHUD showWithStatus:message];
    [self showImage:nil status:message];
    
}

#pragma mark - 显示打钩
+ (void)showSuccessWithStatus:(NSString *)status
{
    [self initSVProgressHUD];
    [SVProgressHUD showSuccessWithStatus:status];
    // 延迟加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - 显示错误
+ (void)showErrorWithStatus:(NSString *)status
{
    [self initSVProgressHUD];
    [SVProgressHUD showErrorWithStatus:status];
    // 延迟加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - 自定义提示框的图片和文字
+ (void)showImage:(UIImage*)image status:(NSString*)status
{
    [self initSVProgressHUD];
    [SVProgressHUD showImage:image status:status];
    // 延迟加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

+ (void)showLoading
{
    [self showLoading:@"请稍候..."];
}

+ (void)showLoading:(NSString *)message
{
    MBProgressHUD *hud = [self Hud];
;
    hud.labelText=message;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelFont=[UIFont systemFontOfSize:13];
    [hud showAnimated:YES whileExecutingBlock:^{
        
    }];
//    [hud showAnimated:YES];
}

+ (void)hideHUD
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:APP.keyWindow];
    [hud hide:YES afterDelay:0.8f];
//    [hud hideAnimated:YES];
}


#pragma mark -
//  检测手机号码是否合法
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    /**
     * 虚拟运营商 170
     */
    NSString * VO = @"^1(7[0-9])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestvo = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VO];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestvo evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//  判断邮箱
+(BOOL)isValidateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
