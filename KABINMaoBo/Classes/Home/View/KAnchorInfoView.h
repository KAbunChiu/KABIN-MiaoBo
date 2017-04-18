//
//  KAnchorInfoView.h
//  KABINMaoBo
//
//  Created by KAbun on 17/1/18.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHomeModel.h"
#import "KNewModel.h"
@class list;

@interface KAnchorInfoView : UIView

@property(nonatomic,strong) list *model;
@property(nonatomic,strong) NSArray *funsModel;

/**Model*/
@property(nonatomic,strong) NewList *listModel;
@property(nonatomic,copy)  NSString *type;
+ (instancetype)anchorInfoView;

@property(nonatomic,copy) void(^selected)();
@end
