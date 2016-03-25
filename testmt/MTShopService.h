//
//  MTShopService.h
//  testmt
//
//  Created by yzl on 16/3/21.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTNetworkManager.h"


@interface MTShopService : NSObject

/**
 *  团购商品种类信息
 *
 *  @param success
 *  @param failure
 */
+ (void)cateDataWithScuccess:(Success)success Failure:(Failure)failure;

/**
 *  团购商品信息
 *
 *  @param success
 *  @param failure 
 */
+ (void)shopDataWithScuccess:(Success)success Failure:(Failure)failure;

@end
