//
//  MTNetworkManager.m
//  testmt
//
//  Created by yzl on 16/3/8.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTNetworkManager.h"

@implementation MTNetworkManager

+ (void)GETWithURL:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [[AFHTTPSessionManager manager] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
