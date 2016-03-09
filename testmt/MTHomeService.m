//
//  MTHomeService.m
//  testmt
//
//  Created by yzl on 16/3/8.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTHomeService.h"
#import "MTConst.h"
#import "MTDiscountItem.h"
#import <YYModel.h>

@implementation MTHomeService


+ (void)discountDataWithSuccess:(SuccessHome)success failure:(Failure)failure{

    [MTNetworkManager GETWithURL:MTDiscountURL params:nil success:^(id response) {
        NSArray* data = [NSArray yy_modelArrayWithClass:[MTDiscountItem class] json:response[@"data"]];;
        if (data) {
            success(data);
            NSLog(@"--------成功获取打折数据---------");
            NSLog(@"%@",response[@"data"]);
        }else{
            NSLog(@"---------获取打折数据失败--------");
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}



@end
