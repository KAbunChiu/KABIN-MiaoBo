//
//  HeaderPre.h
//  KABINMaoBo
//
//  Created by KAbun on 17/1/13.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#ifndef HeaderPre_h
#define HeaderPre_h

#import "UIView+Extension.h"
#import "UIImage+Extension.h"

#ifdef DEBUG
#define KLog(...) NSLog(__VA_ARGS__)
#else
#define KLog(...)
#endif

// 颜色
#define KColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define KBasicColor KColor(214, 41, 117)


//屏幕宽高
#define KScrennWidth [[UIScreen mainScreen] bounds].size.width
#define KScrennHeight [[UIScreen mainScreen] bounds].size.height



#define MBNet @"http://live.9158.com/Room/"

#endif /* HeaderPre_h */
