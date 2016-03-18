//
//  MTShopItem.h
//  testmt
//
//  Created by yzl on 16/3/17.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTShopTypeItem : NSObject

@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSArray *list;

@end
