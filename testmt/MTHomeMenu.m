//
//  MTHomeMenu.m
//  testmt
//
//  Created by yzl on 16/3/4.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTHomeMenu.h"
#import "YYCGUtilities.h"
#import "UIView+YYAdd.h"
#import "UIDevice+YYAdd.h"
#import "MTMenuButton.h"
#import "UIImage+YYAdd.h"
#import "UIColor+YYAdd.h"
#import "MTHomeScrollView.h"


@interface MTHomeMenu ()

@property(nonatomic,strong) MTHomeScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *page;

@end

@implementation MTHomeMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kHomeMenuViewH);
        [self initMenus];
    }
    return self;
}

- (void)initMenus{
    CGFloat bw,bh = kHomeMenuViewH/2;
    int totalBtn;
    if (kScreenWidth<=320) {
        bw = kScreenWidth/4;
        totalBtn = 4*2*2;
    }
    else
    {
        totalBtn = 5*2*2;
        bw = kScreenWidth/5;
    }
    NSArray *items = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"homemenuitems" ofType:@"plist"]];
    NSMutableArray *btns = [NSMutableArray arrayWithCapacity:totalBtn];
    CGRect btnFrame = CGRectMake(0, 0, bw, bh);
    for (NSInteger i = 0; i<totalBtn; i++) {
        NSDictionary *dic = items[i];
        btnFrame.origin = CGPointMake(i%(totalBtn/2)*bw, i/(totalBtn/2)*bh);
        MTMenuButton *btn = [self createMenuBtnWithName:dic[@"name"] img:dic[@"image"] frame:btnFrame];
//        btn.backgroundColor = [UIColor yellowColor];
        [self.scrollView addSubview:btn];
        [btns addObject:btn];
    }
    _menus = [NSArray arrayWithArray:btns];
}
- (MTMenuButton*)createMenuBtnWithName:(NSString*)name img:(NSString*)image frame:(CGRect)frame{
    MTMenuButton *button = [MTMenuButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:name forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:UIColorRGB(223, 223, 223)] forState:UIControlStateHighlighted];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [button performSelector:@selector(setScrollView:) withObject:self.scrollView];
    return button;
}

- (MTHomeScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[MTHomeScrollView alloc] initWithFrame:self.bounds];
        _scrollView.contentSize = CGSizeMake(kScreenWidth*2, self.height);
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

@end
