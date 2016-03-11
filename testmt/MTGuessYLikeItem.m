//
//  MTGuessYLikeItem.m
//  testmt
//
//  Created by yzl on 16/3/10.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTGuessYLikeItem.h"

@implementation MTGuessYLikeItem

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary*)dic{
    if (_range && _mtitle) {
        self.dtitle = [NSString stringWithFormat:@"[%@]%@",_range,_mtitle];
    }
    NSString* str = [self.squareimgurl.absoluteString stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    self.squareimgurl = [NSURL URLWithString:str];

    return YES;
}
@end
