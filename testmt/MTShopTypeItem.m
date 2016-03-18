//
//  MTShopItem.m
//  testmt
//
//  Created by yzl on 16/3/17.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTShopTypeItem.h"

@implementation MTShopTypeItem

+ (NSDictionary*)modelContainerPropertyGenericClass{
    return @{
             @"list":[MTShopTypeItem class]
             };
}

@end
