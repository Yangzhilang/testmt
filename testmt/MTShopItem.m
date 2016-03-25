//
//  MTShopItem.m
//  testmt
//
//  Created by yzl on 16/3/23.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTShopItem.h"

@implementation MTShopItem

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary*)dic{
    NSString* str = [self.frontImg.absoluteString stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    self.frontImg = [NSURL URLWithString:str];
    return YES;
}

@end
