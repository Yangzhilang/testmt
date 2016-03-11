//
//  MTGuessYLikeCell.h
//  testmt
//
//  Created by yzl on 16/3/10.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MTGuessYLikeCellH 90
@class MTGuessYLikeItem;
@interface MTGuessYLikeCell : UITableViewCell

@property(nonatomic,strong)MTGuessYLikeItem *item;
+ (instancetype)cellWithTableView:(UITableView*)tableView;

@end
