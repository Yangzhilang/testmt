//
//  MTHomeDiscountView.m
//  testmt
//
//  Created by yzl on 16/3/9.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTHomeDiscountView.h"
#import "MTDiscountBtn.h"
#import <YYCategories/UIView+YYAdd.h>
#import <UIImage+YYAdd.h>
#import <YYCategories/YYCGUtilities.h>
#import <UIColor+YYAdd.h>

#define MTDiscountBtnH 60

@interface MTHomeDiscountView ()

@property(nonatomic,strong)NSArray *buttons;

@end

@implementation MTHomeDiscountView

- (instancetype)init{
    if (self = [super init]) {

    }
    return self;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    NSMutableArray *btns = [NSMutableArray arrayWithCapacity:items.count];
    for (MTDiscountItem* item in items) {
        MTDiscountBtn *btn = [self createDiscountBtn:item];
        [self addSubview:btn];
    }
    self.buttons = btns;
}

- (MTDiscountBtn*)createDiscountBtn:(MTDiscountItem*)item{

    MTDiscountBtn *btn = [MTDiscountBtn buttonWithType:UIButtonTypeCustom];
    btn.item = item;
    btn.bounds = CGRectMake(0, 0, kScreenWidth/2, MTDiscountBtnH);
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    btn.layer.borderWidth = .25;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [btn setBackgroundImage:[UIImage imageWithColor:UIColorRGB(240, 240, 240)] forState:UIControlStateHighlighted];
    return btn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    int index = 0;
    CGFloat w = kScreenWidth/2;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[MTDiscountBtn class]]) {
            MTDiscountBtn *btn = (MTDiscountBtn*)view;
            btn.left = index%2*w;
            btn.top = index/2*MTDiscountBtnH;
            index++;
        }
    }
}

@end
