//
//  MTHomeScrollView.m
//  testmt
//
//  Created by yzl on 16/3/7.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTHomeScrollView.h"

@implementation MTHomeScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    [super touchesShouldCancelInContentView:view];
    return YES;
}

@end
