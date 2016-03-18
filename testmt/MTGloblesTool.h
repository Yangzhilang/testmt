//
//  MTGlobelsTool.h
//  testmt
//
//  Created by yzl on 16/3/8.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#define MTThemeColorPath @"themecolor.mt"
#define kMTCityString @"mtcity"

@interface MTGloblesTool : NSObject
/**
 *  位置信息
 */
@property(nonatomic,strong,readonly)CLLocation* location;

/**
 *  初始化定位服务
 */
- (void)initService;

/**
 *  检查位置信息是否开启了
 *
 *  @return 
 */
- (BOOL)checkLocationEnabled;

/**
 *  获取该对象单例
 *
 *  @return MTGloblesTool instance
 */
+ (instancetype)sharedTool;

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

/**
 *  保存的城市
 *
 *  @return
 */
+ (NSString*)storedCity;

/**
 *  设置城市
 *
 *  @param city 
 */
+ (void)setCity:(NSString*)city;

@end
