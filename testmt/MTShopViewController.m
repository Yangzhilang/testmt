//
//  ShopViewController.m
//  testmt
//
//  Created by yzl on 16/3/16.
//  Copyright © 2016年 yzl. All rights reserved.
//

#import "MTShopViewController.h"
#import "MTShopChooseBtn.h"

@interface MTShopViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)MTShopChooseBtn *left;
@property(nonatomic,strong)MTShopChooseBtn *right;

@property(nonatomic,weak)MTShopChooseBtn *lastSelBtn;

@end

@implementation MTShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
}

- (void)setupNav{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 32)];
    [titleView addSubview:self.left];
    [titleView addSubview:self.right];
    [self onSegSelected:self.left];
    self.navigationItem.titleView = titleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSegSelected:(MTShopChooseBtn*)sender{
    if (self.lastSelBtn == sender) {
        return;
    }
    self.lastSelBtn.selected = NO;
    self.lastSelBtn = sender;
    self.lastSelBtn.selected = YES;
}

- (MTShopChooseBtn*)left{
    if (!_left) {
        _left = [MTShopChooseBtn buttonWithType:UIButtonTypeCustom];
        _left.frame = CGRectMake(0, 0, 90, 32);
        UIImage *SImage = [UIImage imageNamed:@"btn_banklist_filter_left_selected"];
        SImage = [SImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
        [_left setBackgroundImage:SImage forState:UIControlStateSelected];
        UIImage *NImage = [UIImage imageNamed:@"btn_banklist_filter_left_normal"];
        [_left setTitle:@"全部商家" forState:UIControlStateNormal];
        _left.titleLabel.font = [UIFont systemFontOfSize:13];
        [_left setTitleColor:[MTGloblesTool themeColor] forState:UIControlStateNormal];
        [_left setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        NImage = [NImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 0,0)];
        [_left setBackgroundImage:NImage forState:UIControlStateNormal];
        [_left addTarget:self action:@selector(onSegSelected:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _left;
}

- (MTShopChooseBtn*)right{
    if (!_right) {
        _right = [MTShopChooseBtn buttonWithType:UIButtonTypeCustom];
        _right.frame = CGRectMake(90, 0, 90, 32);
        UIImage *SImage = [UIImage imageNamed:@"btn_banklist_filter_right_selected"];
        SImage = [SImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 5, 5)];
        [_right setBackgroundImage:SImage forState:UIControlStateSelected];
        UIImage *NImage = [UIImage imageNamed:@"btn_banklist_filter_right_normal"];
        NImage = [NImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 5,5)];
        [_right setBackgroundImage:NImage forState:UIControlStateNormal];
        [_right addTarget:self action:@selector(onSegSelected:) forControlEvents:UIControlEventTouchUpInside];
        _right.titleLabel.font = [UIFont systemFontOfSize:13];
        [_right setTitleColor:[MTGloblesTool themeColor] forState:UIControlStateNormal];
        [_right setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_right setTitle:@"优惠商家" forState:UIControlStateNormal];

    }
    return _right;
}




@end
