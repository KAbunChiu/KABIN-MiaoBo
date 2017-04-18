//
//  KHomeModel.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/16.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KHomeModel.h"
#import <MJExtension.h>


@implementation list



@end

@implementation hotswitch2



@end

@implementation hotswitch



@end

@implementation data

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"hotswitch2":@"hotswitch2",@"hotswitch":@"hotswitch",@"list":@"list"};
}

@end

@implementation KHomeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data":@"data"};
}

@end
