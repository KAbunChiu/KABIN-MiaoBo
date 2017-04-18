//
//  KNewCell.h
//  KABINMaoBo
//
//  Created by KAbun on 17/1/17.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNewModel.h"
@class NewList;
@interface KNewCell : UICollectionViewCell
@property(nonatomic,strong) NewList *model;
@end
