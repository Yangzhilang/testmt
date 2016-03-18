//
//  MTShopTypeView.m
//  testmt
//
//  Created by yzl on 16/3/18.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTShopTypeView.h"
#import "MTShopTypeBtn.h"

@interface MTShopTypeView ()

@property(nonatomic,strong)MTShopTypeBtn *shopTypeBtn;
@property(nonatomic,strong)MTShopTypeBtn *regionTypeBtn;
@property(nonatomic,strong)MTShopTypeBtn *disTypeBtn;

@end

@implementation MTShopTypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    frame.size.width = kScreenWidth;
    frame.origin.x = 0;
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    CGFloat w = kScreenWidth/self.subviews.count;
    CGFloat x = 0;
    for (UIButton *btn in self.subviews) {
        btn.frame = CGRectMake(x, 0, w, self.height);
        x += w;
    }
}

- (MTShopTypeBtn*)createBtnWithImageName:(NSString*)name title:(NSString*)title{
    MTShopTypeBtn *btn = [MTShopTypeBtn buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [btn setTitleColor:[MTGloblesTool themeColor] forState:UIControlStateSelected];
    [self addSubview:btn];
    return btn;
}

- (MTShopTypeBtn*)shopTypeBtn{
    if (!_shopTypeBtn) {
        _shopTypeBtn = [self createBtnWithImageName:@"" title:@"摄影写真"];
    }
    return _shopTypeBtn;
}

- (MTShopTypeBtn*)regionTypeBtn{
    if (!_regionTypeBtn) {
        _shopTypeBtn = [self createBtnWithImageName:@"" title:@"全部"];
    }
    return _shopTypeBtn;
}

- (MTShopTypeBtn*)disTypeBtn{
    if (!_disTypeBtn) {
        _disTypeBtn = [self createBtnWithImageName:@"" title:@"智能推荐"];
    }
    return _disTypeBtn;
}

@end
