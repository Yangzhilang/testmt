//
//  MTDiscountItem.h
//  testmt
//
//  Created by yzl on 16/3/8.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTDiscountItem : NSObject

@property(nonatomic,assign)NSInteger position;
@property(nonatomic,copy)NSString *typeface_color;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,copy)NSString* title;
@property(nonatomic,assign)BOOL module;
@property(nonatomic,copy)NSString *maintitle;
@property(nonatomic,strong)NSString *tplurl;
@property(nonatomic,assign)int type;
@property(nonatomic,strong)NSURL *imageurl;
@property(nonatomic,assign)NSInteger solds;
@property(nonatomic,copy)NSString *deputytitle;

@end
