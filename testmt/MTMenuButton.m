//
//  MTMenuButton.m
//  testmt
//
//  Created by yzl on 16/3/4.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTMenuButton.h"
#import "UIView+YYAdd.h"
#import "MTHomeScrollView.h"

@interface MTMenuButton ()

@property(nonatomic,weak)MTHomeScrollView *scrollView;

@end

@implementation MTMenuButton

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
    self.imageView.size = CGSizeMake(50, 50);
    self.titleLabel.size = CGSizeMake(50, 20);
//    NSLog(@"%@",NSStringFromCGRect(self.titleLabel.frame));
    self.imageView.center = CGPointMake(cx, cy-self.imageView.height/2+15);
    self.titleLabel.center = CGPointMake(cx, cy+self.titleLabel.height/2+15);
}


//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesMoved:touches withEvent:event];
//    
////    UITouch *touch = [touches anyObject];
////    CGPoint location = [touch locationInView:self];
////    if (location) {
////        <#statements#>
////    }
////    [self.nextResponder touchesMoved:<#(nonnull NSSet<UITouch *> *)#> withEvent:<#(nullable UIEvent *)#>]
//    if (_scrollView) {
//        [_scrollView touchesShouldCancelInContentView:self];
//    }
//}

@end
