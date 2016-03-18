//
//  MTGlobelsTool.m
//  testmt
//
//  Created by yzl on 16/3/8.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTGloblesTool.h"
#import "UIColor+YYAdd.h"

@interface MTGloblesTool ()<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locMananger;

@end

@implementation MTGloblesTool


static UIColor *g_themeColor;

+ (instancetype)sharedTool{
    static MTGloblesTool* tool = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        tool = [[MTGloblesTool alloc] init];
    });
    return tool;
}

//- (instancetype)init{
//    if(self=[super init]){
//        [self _initLocation]; //初始化定位
//    }
//    return self;
//}

- (void)initService{
    [self _initLocation];
}

- (BOOL)checkLocationEnabled{
    return [CLLocationManager locationServicesEnabled];
}

+ (NSString*)themeFile{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSUserDirectory, NSUserDomainMask, YES).firstObject;
    return [path stringByAppendingPathComponent:MTThemeColorPath];
}

+ (UIColor*)themeColor{
    if (!g_themeColor) {
        g_themeColor = [NSKeyedUnarchiver unarchiveObjectWithFile:[self themeFile]];
        if (!g_themeColor) {
            g_themeColor = UIColorRGB(62, 184, 175);
        }
    }
    return g_themeColor;
}

+ (void)setThemeColor:(UIColor *)color{
    g_themeColor = color;
    [NSKeyedArchiver archiveRootObject:g_themeColor toFile:[self themeFile]];
}

#pragma mark - private

#pragma mark - 初始化定位

- (void)_initLocation{
    if ([CLLocationManager locationServicesEnabled]) {
        _locMananger = [[CLLocationManager alloc] init];
        _locMananger.delegate = self;
        _locMananger.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locMananger.distanceFilter = 100;
        if ([UIDevice systemVersion]>=8.0) {
            [_locMananger requestWhenInUseAuthorization];
            [_locMananger requestAlwaysAuthorization];
        }
        [_locMananger startUpdatingLocation];
    }

}

#pragma mark -
#pragma mark - delegate
#pragma mark - 定位
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    DDLogError(@"定位失败");
    DDLogError(@"%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    _location = locations.lastObject;
    DDLogDebug(@"定位成功");
    DDLogDebug(@"经度:%f,纬度:%f",_location.coordinate.latitude,_location.coordinate.longitude);
    DDLogVerbose(@"详细信息：%@",_location);
}

+ (NSString*)storedCity{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kMTCityString];
}

+ (void)setCity:(NSString *)city{
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:kMTCityString];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
