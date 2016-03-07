//
//  MTGlobelsTool.h
//  testmt
//
//  Created by yzl on 16/3/8.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTGlobelsTool : NSObject

#define MTThemeColorPath @"themecolor.mt"

/**
 *  获取主题色
 *
 *  @return 主题色
 */
+ (UIColor*)themeColor;

/**
 *  设置主题色
 *
 *  @param color 
 */
+ (void)setThemeColor:(UIColor*)color;

@end
