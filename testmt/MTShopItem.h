//
//  MTShopItem.h
//  testmt
//
//  Created by yzl on 16/3/23.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTShopItem : NSObject

@property (nonatomic, strong) NSURL *frontImg;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) float avgScore;//星星
@property (nonatomic, assign) NSInteger markNumbers;//评价个数
@property (nonatomic, copy) NSString *cateName;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, assign) float avgPrice;

@end
