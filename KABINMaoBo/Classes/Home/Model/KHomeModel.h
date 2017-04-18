//
//  KHomeModel.h
//  KABINMaoBo
//
//  Created by KAbun on 17/1/16.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface list : NSObject

@property (nonatomic, strong) NSNumber * allnum;
@property (nonatomic, copy) NSString * bigpic;
@property (nonatomic, strong) NSNumber * curexp;
@property (nonatomic, strong) NSNumber * distance;
@property (nonatomic, copy) NSString * familyName;
@property (nonatomic, copy) NSString * flv;
@property (nonatomic, strong) NSNumber * gender;
@property (nonatomic, copy) NSString * gps;
@property (nonatomic, strong) NSNumber * grade;
@property (nonatomic, strong) NSNumber * isSign;
@property (nonatomic, strong) NSNumber * level;
@property (nonatomic, copy) NSString * myname;
@property (nonatomic, copy) NSString * nation;
@property (nonatomic, copy) NSString * nationFlag;
@property (nonatomic, strong) NSNumber * pos;
@property (nonatomic, strong) NSNumber * roomid;
@property (nonatomic, strong) NSNumber * serverid;
@property (nonatomic, copy) NSString * signatures;
@property (nonatomic, copy) NSString * smallpic;
@property (nonatomic, strong) NSNumber * starlevel;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, strong) NSNumber * useridx;

@end

@interface hotswitch2 : NSObject

@property (nonatomic, copy) NSString * endtime;
@property (nonatomic, copy) NSString * starttime;

@end

@interface hotswitch : NSObject

@property (nonatomic, copy) NSString * endtime;
@property (nonatomic, copy) NSString * starttime;

@end


@interface data : NSObject

@property (nonatomic, strong) NSNumber * hotConfig;
@property (nonatomic, strong) hotswitch * hotswitch;
@property (nonatomic, strong) NSArray<hotswitch2 *> * hotswitch2;
@property (nonatomic, strong) NSArray<list *> * list;
@property (nonatomic, strong) NSNumber * samecity;
@property (nonatomic, strong) NSNumber * totalPage;

@end


@interface KHomeModel : NSObject
@property(nonatomic,copy)  NSString  *mag;
@property(nonatomic,strong) data *data;
@property(nonatomic,copy) NSString *code;
@end
