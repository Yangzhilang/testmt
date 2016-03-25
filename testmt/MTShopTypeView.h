//
//  MTShopTypeView.h
//  testmt
//
//  Created by yzl on 16/3/18.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTShopTypeBtn;
@protocol MTShopTypeDelegate <NSObject>

@optional
- (void)onItemTouched:(NSInteger)index;

@end

@interface MTShopTypeView : UIView

@property(nonatomic,weak)id<MTShopTypeDelegate> delegate;
@property(nonatomic,weak)MTShopTypeBtn *lastSelBtn;

@end
