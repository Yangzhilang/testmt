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
#import "MTGloblesTool.h"
#import "MTGuessYLikeItem.h"
@implementation MTHomeService


+ (void)discountDataWithSuccess:(SuccessHome)success failure:(Failure)failure{

    [MTNetworkManager GETWithURL:MTDiscountURL params:nil success:^(id response) {
        NSArray* data = [NSArray yy_modelArrayWithClass:[MTDiscountItem class] json:response[@"data"]];;
        if (data) {
            success(data);
            DDLogInfo(@"--------成功获取打折数据---------");
            DDLogInfo(@"打折数据Count:%ld",[response[@"data"]count]);
            DDLogVerbose(@"%@",response[@"data"]);
        }else{
            DDLogInfo(@"---------获取打折数据失败--------");
        }
    } failure:^(NSError *error) {
        DDLogInfo(@"---------获取打折数据失败--------");
        DDLogError(@"%@",error);
        failure(error);
    }];
}

+ (void)guessYouLikeDataWithScueess:(SuccessHome)success failure:(Failure)failure{
    MTGloblesTool *tool = [MTGloblesTool sharedTool];
    NSString *url = [NSString stringWithFormat:MTGULULR,tool.location.coordinate.latitude,tool.location.coordinate.longitude];
//    DDLogDebug(@"%@",url);
    [MTNetworkManager GETWithURL:url params:nil success:^(id response) {
        NSArray* data = [NSArray yy_modelArrayWithClass:[MTGuessYLikeItem class] json:response[@"data"]];;
        if (data) {
            success(data);
            DDLogInfo(@"--------成功获取猜你喜欢数据---------");
            DDLogDebug(@"猜你喜欢数据Count:%ld",[response[@"data"]count]);
            DDLogVerbose(@"%@",response[@"data"]);
        }else{
            DDLogInfo(@"---------获取猜你喜欢数据失败--------");
        }
    } failure:^(NSError *error) {
        DDLogInfo(@"---------获取猜你喜欢失败--------");
        DDLogError(@"%@",error);
        failure(error);
    }];
}

+ (void)cityDataWithSuccess:(SuccessHome)success failure:(Failure)failure{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *path =[[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
        NSArray *data = [NSArray arrayWithContentsOfFile:path];
        dispatch_async(dispatch_get_main_queue(), ^{
            DDLogInfo(@"----成功获取城市数据----");
            success(data);
        });
    });
}



@end
