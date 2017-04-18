//
//  KNewModel.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/17.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KNewModel.h"
#import <MJExtension.h>

@implementation NewList

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Num":@"new"};
}

@end

@implementation NewData

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":@"NewList"};
}

@end

@implementation KNewModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"NewData":@"data"};
}

@end
