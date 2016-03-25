//
//  MTShopChooseView.h
//  testmt
//
//  Created by yzl on 16/3/16.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTShopChooseView : UIView

@property(nonatomic,strong)UITableView *leftTable;
@property(nonatomic,strong)UITableView *rightTable;


@property(nonatomic,strong)NSArray *shopTypeItems; ///<table 数据
@property(nonatomic,assign)BOOL open; ///< 是否弹出flag


/**
 *  弹出
 */
- (void)pop;
/**
 *  弹回
 */
- (void)unPop;

@end
