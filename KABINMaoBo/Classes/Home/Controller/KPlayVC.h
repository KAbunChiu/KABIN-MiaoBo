//
//  KPlayVC.h
//  KABINMaoBo
//
//  Created by KAbun on 17/1/18.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  list;
@interface KPlayVC : UIViewController

@property(nonatomic,strong)list *model;
@property (nonatomic, strong) NSArray *allModels;

@property (nonatomic, strong) UIImage *image;

@end
