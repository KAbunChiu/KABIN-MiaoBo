//
//  KTagsButton.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/13.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KTagsButton.h"

@implementation KTagsButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:KColor(215, 42, 144) forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];

    }
    return self;
}

@end
