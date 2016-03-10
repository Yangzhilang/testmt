//
//  MTDiscountItem.m
//  testmt
//
//  Created by yzl on 16/3/8.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTDiscountItem.h"

@implementation MTDiscountItem

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary*)dic{
    NSString* str = [self.imageurl.absoluteString stringByReplacingOccurrencesOfString:@"w.h" withString:@"120.0"];
    self.imageurl = [NSURL URLWithString:str];
    return YES;
}

@end
