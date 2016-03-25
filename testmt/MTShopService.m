//
//  MTShopService.m
//  testmt
//
//  Created by yzl on 16/3/21.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTShopService.h"
#import "MTShopTypeItem.h"
#import "MTShopItem.h"

@implementation MTShopService

+ (void)cateDataWithScuccess:(Success)success Failure:(Failure)failure{
    [MTNetworkManager GETWithURL:MTCATEURL params:nil success:^(id response) {
        NSArray* data = [NSArray yy_modelArrayWithClass:[MTShopTypeItem class] json:response[@"data"]];;
        if (data) {
            success(data);
            DDLogInfo(@"--------成功获取cate数据---------");
            DDLogInfo(@"cate数据Count:%ld",[response[@"data"]count]);
            DDLogVerbose(@"%@",response[@"data"]);
        }else{
            DDLogInfo(@"---------获取cate数据失败--------");
        }
    } failure:^(NSError *error) {
        DDLogError(@"---------获取cate数据失败--------");
        DDLogError(@"%@",error);
        failure(error);
    }];
}

+ (void)shopDataWithScuccess:(Success)success Failure:(Failure)failure{
    [MTNetworkManager GETWithURL:MTSHOPURL params:nil success:^(id response) {
        NSArray* data = [NSArray yy_modelArrayWithClass:[MTShopItem class] json:response[@"data"]];;
        if (data) {
            success(data);
            DDLogInfo(@"--------成功获取团购商品数据---------");
            DDLogInfo(@"cate数据Count:%ld",[response[@"data"]count]);
            DDLogVerbose(@"%@",response[@"data"]);
        }else{
            DDLogInfo(@"---------获取团购商品数据失败--------");
        }
    } failure:^(NSError *error) {
        DDLogError(@"---------获取团购商品数据失败--------");
        DDLogError(@"%@",error);
        failure(error);
    }];
}

@end
