//
//  MTShopCell.h
//  testmt
//
//  Created by yzl on 16/3/23.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MTShopCellH 90

@class MTShopItem;
@interface MTShopCell : UITableViewCell

@property(nonatomic,strong)MTShopItem *item;

+ (instancetype)cellWithTableView:(UITableView*)tableView;

@end
