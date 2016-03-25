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
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, .5)];
        line.backgroundColor = UIColorRGB(236, 236, 236);
        [self addSubview:line];

        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, .5)];
        line2.backgroundColor = UIColorRGB(236, 236, 236);
        line2.origin = CGPointMake(0, frame.size.height-1);
        [self addSubview:line2];

        self.shopTypeBtn.hidden = NO;
        self.regionTypeBtn.hidden = NO;
        self.disTypeBtn.hidden = NO;
    }
//    self.backgroundColor = [UIColor orangeColor];
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    CGFloat w = kScreenWidth/3;
    CGFloat x = 0;
    for (UIButton *btn in self.subviews) {
        if (![btn isKindOfClass:[UIButton class]]) {
            continue;
        }
        btn.frame = CGRectMake(x, 0, w, self.height);
        x += w;
    }
}

- (MTShopTypeBtn*)createBtnWithImageName:(NSString*)name title:(NSString*)title{
    MTShopTypeBtn *btn = [MTShopTypeBtn buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_arrow_green"] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[MTGloblesTool themeColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(onButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

- (void)onButtonTouched:(UIButton*)sender{
    if (sender != self.shopTypeBtn) {
        return;
    }
    self.lastSelBtn = self.shopTypeBtn;
    sender.selected = !sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onItemTouched:
                                                                     )]) {
        [self.delegate onItemTouched:0];
    }
}

- (MTShopTypeBtn*)shopTypeBtn{
    if (!_shopTypeBtn) {
        _shopTypeBtn = [self createBtnWithImageName:@"arrow_down" title:@"摄影写真"];
    }
    return _shopTypeBtn;
}

- (MTShopTypeBtn*)regionTypeBtn{
    if (!_regionTypeBtn) {
        _regionTypeBtn = [self createBtnWithImageName:@"arrow_down" title:@"全部"];
    }
    return _regionTypeBtn;
}

- (MTShopTypeBtn*)disTypeBtn{
    if (!_disTypeBtn) {
        _disTypeBtn = [self createBtnWithImageName:@"arrow_down" title:@"智能推荐"];
    }
    return _disTypeBtn;
}

@end
