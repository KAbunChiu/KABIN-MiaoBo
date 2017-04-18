//
//  KBottomToolView.h
//  KABINMaoBo
//
//  Created by KAbun on 17/1/18.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBottomToolView : UIView
@property (nonatomic, copy) void (^clickToolBlock)(NSInteger tag);
@end
