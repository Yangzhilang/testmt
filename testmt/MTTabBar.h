//
//  MTTabBar.h
//  testmt
//
//  Created by yzl on 16/3/4.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TabBarBlock)(NSInteger index);

@interface MTTabBar : UIView

@property(nonatomic,copy) TabBarBlock block;

@end
