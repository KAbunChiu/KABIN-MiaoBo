//
//  KWatchVC.h
//  KABINMaoBo
//
//  Created by KAbun on 17/1/20.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class list;
@class NewList;
@interface KWatchVC : UIViewController

@property(nonatomic,copy)  NSString  *URL;
/**粉丝*/
@property(nonatomic,strong)NSMutableArray *funsArrM;
/**Model*/
@property(nonatomic,strong) list *model;
/**Model*/
@property(nonatomic,strong) NewList *listModel;


@end
