//
//  UIBarButtonItem+KABIN.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/13.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "UIBarButtonItem+KABIN.h"

@implementation UIBarButtonItem (KABIN)

+ (instancetype)barButtonItemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage targer:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.imageView.image=[UIImage imageNamed:image];
    btn.imageView.highlightedImage=[UIImage imageNamed:highlightImage];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:btn];
}

@end
