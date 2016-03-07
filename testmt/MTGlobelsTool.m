//
//  MTGlobelsTool.m
//  testmt
//
//  Created by yzl on 16/3/8.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTGlobelsTool.h"
#import "UIColor+YYAdd.h"

@implementation MTGlobelsTool

static UIColor *g_themeColor;

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



@end
