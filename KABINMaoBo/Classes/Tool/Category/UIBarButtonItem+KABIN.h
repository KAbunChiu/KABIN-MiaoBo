//
//  UIBarButtonItem+KABIN.h
//  KABINMaoBo
//
//  Created by KAbun on 17/1/13.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (KABIN)

+ (instancetype)barButtonItemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage targer:(id)target action:(SEL)action;

@end
