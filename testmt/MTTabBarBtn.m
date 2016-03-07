//
//  MTTabBarBtn.m
//  testmt
//
//  Created by yzl on 16/3/4.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTTabBarBtn.h"
#import "UIView+YYAdd.h"

@implementation MTTabBarBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat cx = self.width/2;
    CGFloat cy = self.height/2;
    self.imageView.center = CGPointMake(cx, cy-self.imageView.height/2+6);
    self.titleLabel.center = CGPointMake(cx, cy+self.titleLabel.height/2+6);
}

- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
