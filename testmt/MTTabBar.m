//
//  MTTabBar.m
//  testmt
//
//  Created by yzl on 16/3/4.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTTabBar.h"
#import "UIView+YYAdd.h"
#import "MTTabBarBtn.h"
#import "UIColor+YYAdd.h"

@interface MTTabBar ()

@property(nonatomic,strong)NSMutableArray *buttons;
@property(nonatomic,weak)MTTabBarBtn *curSelectedBtn;

@end

@implementation MTTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initBtns];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initBtns{

    CGRect frame = CGRectZero;
    [self.buttons addObject:[self createMenuBtnWithName:@"首页" img:@"icon_tabbar_homepage" frame:frame]];
    [self.buttons addObject:[self createMenuBtnWithName:@"商家" img:@"icon_tabbar_merchant" frame:frame]];
    [self.buttons addObject:[self createMenuBtnWithName:@"我的" img:@"icon_tabbar_mine" frame:frame]];

    [self.buttons addObject:[self createMenuBtnWithName:@"更多" img:@"icon_tabbar_misc" frame:frame]];

    MTTabBarBtn *btn = (MTTabBarBtn*)self.buttons[0];
    self.curSelectedBtn = btn;
    btn.selected = YES;
}

- (MTTabBarBtn*)createMenuBtnWithName:(NSString*)name img:(NSString*)image frame:(CGRect)frame{
    MTTabBarBtn *button = [MTTabBarBtn buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:name forState:UIControlStateNormal];
    NSString *selName = [image stringByAppendingString:@"_selected"];
    [button setImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitleColor:UIColorRGB(153,153,153) forState:UIControlStateNormal];
    [button setTitleColor:UIColorRGB(62, 184, 175) forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:self action:@selector(onButtonTouched:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];

    return button;
}

- (NSMutableArray*)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray arrayWithCapacity:4];
    }
    return _buttons;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.width/4;
    CGRect frame = CGRectMake(0, 0, w, 44);
    for (UIView* view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)view;
            btn.frame = frame;
            frame.origin.x+= w;
        }
    }
}

#pragma mark - 按钮回调

- (void)onButtonTouched:(MTTabBarBtn*)sender{
    if (self.curSelectedBtn == sender) {
        return;
    }
    self.curSelectedBtn.selected = NO;
    self.curSelectedBtn = sender;
    self.curSelectedBtn.selected = YES;
    if (self.block) {
        NSInteger index = [self.buttons indexOfObject:self.curSelectedBtn];
        self.block(index);
    }
}

@end
