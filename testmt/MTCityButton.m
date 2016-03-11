//
//  MTCityButton.m
//  testmt
//
//  Created by yzl on 16/3/11.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTCityButton.h"

#define MTCityBtnH 30.0

@implementation MTCityButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)cityBtn{
    MTCityButton *cityButton = [MTCityButton buttonWithType:UIButtonTypeCustom];
    cityButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cityButton setTitle:@"成都" forState:UIControlStateNormal];
    [cityButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [cityButton setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
    return cityButton;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.titleLabel sizeToFit];

    CGFloat cy = MTCityBtnH/2;
    self.titleLabel.centerX = self.titleLabel.size.width/2;
    self.titleLabel.centerY = cy;

    self.imageView.size = CGSizeMake(15, 12);
    self.imageView.center = CGPointMake(self.titleLabel.right+self.imageView.size.width/2+5, cy);
    self.size = CGSizeMake(self.imageView.right, MTCityBtnH);
}

@end
