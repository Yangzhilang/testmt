//
//  MTDiscountBtn.m
//  testmt
//
//  Created by yzl on 16/3/9.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTDiscountBtn.h"
#import <YYCategories/UIView+YYAdd.h>
#import <YYCategories/UIColor+YYAdd.h>
#import <UIButton+WebCache.h>

#define MTDiscountPadding 10

@interface MTDiscountBtn ()

//- (void)setBigTitle:(NSString*)title color:(UIColor*)color;
//- (void)setSmallTitle:(NSString*)title color:(UIColor*)color;

@property(nonatomic,strong)UILabel *smallLabel;

@end

@implementation MTDiscountBtn

- (void)setItem:(MTDiscountItem *)item{
    _item = item;
    [self setBigTitle:item.maintitle color:[UIColor colorWithHexString:_item.typeface_color]];
    [self setSmallTitle:item.deputytitle color:[UIColor lightGrayColor]];
    [self sd_setImageWithURL:item.imageurl forState:UIControlStateNormal];
    [self sd_setImageWithURL:item.imageurl forState:UIControlStateHighlighted];
}

- (void)setBigTitle:(NSString *)title color:(UIColor *)color{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)setSmallTitle:(NSString *)title color:(UIColor *)color{
    self.smallLabel.text = title;
    self.smallLabel.textColor = color;
    [self.smallLabel sizeToFit];
}

- (void)layoutSubviews{
    [super layoutSubviews];

    self.imageView.size = CGSizeMake(50, 50);
    self.imageView.centerY = self.height/2;
    self.imageView.right = self.width - MTDiscountPadding;

    self.titleLabel.left = MTDiscountPadding;
    self.titleLabel.top = 10;
    self.smallLabel.left = self.titleLabel.left + 5;
    self.smallLabel.top = self.titleLabel.bottom + 5;
}

- (UILabel*)smallLabel{
    if (!_smallLabel) {
        _smallLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _smallLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_smallLabel];
    }
    return _smallLabel;
}

@end
