//
//  MTShopTypeBtn.m
//  testmt
//
//  Created by yzl on 16/3/18.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTShopTypeBtn.h"

@implementation MTShopTypeBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    else{
        self.imageView.transform = CGAffineTransformIdentity;
    }
}

- (void)setHighlighted:(BOOL)highlighted{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];

    self.imageView.size = CGSizeMake(8, self.imageView.height/self.imageView.width*8);
    self.imageView.center = CGPointMake(self.width - self.imageView.width/2-5, self.height/2);
}

@end
