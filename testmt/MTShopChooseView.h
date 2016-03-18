//
//  MTShopChooseView.h
//  testmt
//
//  Created by yzl on 16/3/16.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTShopTypeChooseProtocol <NSObject>

@optional


@end

@interface MTShopChooseView : UIView

@property(nonatomic,strong)UITableView *leftTable;
@property(nonatomic,strong)UITableView *rightTable;
@property(nonatomic,strong)NSArray *shopTypeItems;


@end
