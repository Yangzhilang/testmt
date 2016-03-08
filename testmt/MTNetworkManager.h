//
//  MTNetworkManager.h
//  testmt
//
//  Created by yzl on 16/3/8.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^Success)(id response);
typedef void(^Failure)(NSError *error);
@interface MTNetworkManager : NSObject

+ (void)GETWithURL:(NSString*)url params:(NSDictionary*)params success:(Success)success failure:(Failure)failure;

@end
