//
//  MTHomeService.h
//  testmt
//
//  Created by yzl on 16/3/8.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTNetworkManager.h"

typedef void(^SuccessHome)(NSArray* data);

@interface MTHomeService : NSObject

/**
 *  获取打折数据
 *
 *  @param success
 *  @param failure 
 */
+ (void)discountDataWithSuccess:(SuccessHome)success failure:(Failure)failure;

/**
 *  获取猜你喜欢数据
 *
 *  @param success
 *  @param failure 
 */
+ (void)guessYouLikeDataWithScueess:(SuccessHome)success failure:(Failure)failure;

/**
 *  获取城市列表数据
 *
 *  @param success
 *  @param failure 
 */
+ (void)cityDataWithSuccess:(SuccessHome)success failure:(Failure)failure;

@end
