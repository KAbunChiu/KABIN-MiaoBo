//
//  KBottomToolView.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/18.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KBottomToolView.h"
@interface KBottomToolView()

@end
@implementation KBottomToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setupBasic];
    }
    return self;
}

-(NSArray *)tools{
     return @[@"talk_public_40x40", @"talk_private_40x40", @"talk_sendgift_40x40", @"talk_rank_40x40", @"talk_share_40x40", @"talk_close_40x40"];
}

-(void)setupBasic{
    CGFloat wh=40;
    CGFloat margin=(KScrennWidth-wh*self.tools.count)/(self.tools.count+1.0);
    CGFloat x=0;
    CGFloat y=0;
    for (int i=0; i<self.tools.count; i++) {
        x=margin+(margin+wh)*i;
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(x, y, wh, wh);
        btn.userInteractionEnabled=YES;
        [btn setImage:[UIImage imageNamed:self.tools[i]] forState:UIControlStateNormal];
        btn.tag=i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

-(void)click:(UIButton *)btn{
    if (self.clickToolBlock) {
        self.clickToolBlock(btn.tag);
    }
}

@end
