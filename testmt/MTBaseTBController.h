//
//  MTBaseTBController.h
//  testmt
//
//  Created by yzl on 16/3/4.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefreshGifHeader.h>

@interface MTBaseTBController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end
