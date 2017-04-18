//
//  KCatEarVIew.h
//  KABINMaoBo
//
//  Created by KAbun on 17/1/22.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHomeModel.h"
#import "KNewModel.h"
@class list;
@interface KCatEarVIew : UIView
/**Model*/
@property(nonatomic,strong) list *model;
/**Model*/
@property(nonatomic,strong) NewList *listModel;
@property(nonatomic,copy)  NSString  *type;
+(instancetype)catEarView;
@end
