//
//  UIImageView+Extension.h
//  KABINMaoBo
//
//  Created by KAbun on 17/1/19.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

// 播放GIF
- (void)playGifAnim:(NSArray *)images;
// 停止动画
- (void)stopGifAnim;

@end
