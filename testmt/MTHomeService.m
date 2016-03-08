//
//  MTHomeService.m
//  testmt
//
//  Created by yzl on 16/3/8.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTHomeService.h"
#import "MTNetworkManager.h"
#import "MTConst.h"
#import "MTDiscountItem.h"
#import <YYModel.h>

@implementation MTHomeService

- (void)discountDataWithSuccess:(id)success failure:(id)failure{

    [MTNetworkManager GETWithURL:MTDiscountURL params:nil success:^(id response) {
        NSArray* datas = [NSArray yy_modelArrayWithClass:[MTDiscountItem class] json:response];
    } failure:^(NSError *error) {

    }];
}

@end
