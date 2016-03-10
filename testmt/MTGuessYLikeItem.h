//
//  MTGuessYLikeItem.h
//  testmt
//
//  Created by yzl on 16/3/10.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTGuessYLikeItem : NSObject

@property(nonatomic,copy)NSString *range;
@property(nonatomic,copy)NSString *mtitle;
@property(nonatomic,strong)NSURL *squareimgurl;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSURL *imageurl;
@property(nonatomic,copy)NSString *mname;
@property(nonatomic,copy)NSString *brandname;
@property(nonatomic,assign)NSInteger price;
@property(nonatomic,assign)NSInteger canbuyprice;
@property(nonatomic,copy)NSString *dtitle;

@end
