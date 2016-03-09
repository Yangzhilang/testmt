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

@end
