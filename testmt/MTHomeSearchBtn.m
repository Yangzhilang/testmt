//
//  MTHomeSearchBtn.m
//  testmt
//
//  Created by yzl on 16/3/11.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTHomeSearchBtn.h"

#define MTHomeSearchBtnH 28.0

@implementation MTHomeSearchBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)searchBtn{
    MTHomeSearchBtn *btn = [MTHomeSearchBtn buttonWithType:UIButtonTypeCustom];
    UIImage *bgImage = [UIImage imageNamed:@"background_home_searchBar1"];
    bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(13, 13, 13, 13) resizingMode:UIImageResizingModeTile];
    [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:11.5];
    [btn setTitle:@"输入商家、品类、商圈" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_homepage_search_green"] forState:UIControlStateNormal];

    return btn;
}

- (void)setHighlighted:(BOOL)highlighted{

}

- (void)layoutSubviews{
    [super layoutSubviews];

    CGFloat cy = MTHomeSearchBtnH/2;
    self.imageView.size = CGSizeMake(15, 15);
    self.imageView.centerY = cy;
    self.imageView.left = 10;

    self.titleLabel.left = self.imageView.right + 10;
    self.titleLabel.centerY = cy;
    [self.titleLabel sizeToFit];

    self.size = CGSizeMake(self.titleLabel.right+20, MTHomeSearchBtnH);
}

@end
