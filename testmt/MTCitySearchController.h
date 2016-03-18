//
//  MTCitySearchController.h
//  testmt
//
//  Created by yzl on 16/3/11.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTHomeController;

@interface MTCitySearchController : UITableViewController

@property(nonatomic,weak)MTHomeController *parent;
+ (UIViewController*)controllerWithParent:(MTHomeController*)parent;

@end
