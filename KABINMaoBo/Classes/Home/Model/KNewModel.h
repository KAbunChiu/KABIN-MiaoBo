//
//  KNewModel.h
//  KABINMaoBo
//
//  Created by KAbun on 17/1/17.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewList : NSObject

@property (nonatomic, strong) NSNumber * allnum;
@property (nonatomic, copy) NSString * flv;
@property(nonatomic,strong) NSNumber *Num;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * photo;
@property (nonatomic, copy) NSString * position;
@property (nonatomic, strong) NSNumber * roomid;
@property (nonatomic, strong) NSNumber * serverid;
@property (nonatomic, strong) NSNumber * sex;
@property (nonatomic, strong) NSNumber * starlevel;
@property (nonatomic, strong) NSNumber * useridx;

@end

@interface NewData : NSObject

@property (nonatomic, strong) NSArray<NewList *> * list;
@property (nonatomic, strong) NSNumber * totalPage;

@end

@interface KNewModel : NSObject
@property (nonatomic, copy) NSString * code;
@property (nonatomic, strong) NewData * data;
@property (nonatomic, copy) NSString * msg;
@end
