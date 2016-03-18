//
//  MTRefreshHeader.m
//  testmt
//
//  Created by yzl on 16/3/15.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#define Padding 5
#import "MTRefreshHeader.h"

@implementation MTRefreshHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setPullingPercent:(CGFloat)pullingPercent{
    [super setPullingPercent:pullingPercent];
    if (self.state == MJRefreshStateIdle) {
        [self placeSubviews];
    }
}

- (void)placeSubviews{
    [super placeSubviews];
    self.gifView.contentMode = UIViewContentModeScaleToFill;
    CGSize imageSize = self.gifView.image.size;
    self.gifView.width = imageSize.width - (Padding*2*imageSize.width/imageSize.height);
    self.gifView.centerX = self.scrollView.centerX;
    if (self.state == MJRefreshStateIdle) {
        CGFloat padding = -(self.scrollView.contentOffset.y+kNavigationH);
        self.gifView.width = imageSize.width - (Padding*2*imageSize.width/imageSize.height);
        if (padding<11) {
            self.gifView.height = 1;
            self.gifView.top = self.gifView.image.size.height + self.scrollView.contentOffset.y+kNavigationH+(padding-1)/2;
        }
        else{
            CGFloat height = -(self.scrollView.contentOffset.y+kNavigationH)-2*Padding;
            if (height<0) {
                height=0;
            }
            self.gifView.top = self.gifView.image.size.height + self.scrollView.contentOffset.y+kNavigationH+Padding;
            self.gifView.height = height;
        }
    }
}

//- (void)setState:(MJRefreshState)state{
//    [super setState:state];
//    MJRefreshCheckState
//    if (state == MJRefreshStatePulling) {
//        if (self.) {
//            <#statements#>
//        }
//    }
//}

@end
