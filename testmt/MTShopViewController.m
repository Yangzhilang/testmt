//
//  ShopViewController.m
//  testmt
//
//  Created by yzl on 16/3/16.
//  Copyright © 2016年 yzl. All rights reserved.
//

#import "MTShopViewController.h"
#import "MTShopChooseBtn.h"
#import "MTShopTypeView.h"
#import "MTShopChooseView.h"
#import "MTShopService.h"
#import "MTShopTypeBtn.h"
#import "MTShopCell.h"

@interface MTShopViewController ()<UITableViewDataSource,UITableViewDelegate,MTShopTypeDelegate>

@property(nonatomic,strong)MTShopChooseBtn *left;
@property(nonatomic,strong)MTShopChooseBtn *right;

@property(nonatomic,weak)MTShopChooseBtn *lastSelBtn;
@property(nonatomic,strong)MTShopChooseView *choseView;
@property(nonatomic,strong)MTShopTypeView *shopTypeView;

@property(nonatomic,strong)NSMutableArray *cateData;
@property(nonatomic,strong)NSMutableArray *shopData;

@property(nonatomic,strong)UITableView *shopTable; ///<商品Table

@end

@implementation MTShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];

    self.shopTypeView = [[MTShopTypeView alloc] initWithFrame:CGRectMake(0, 64, 0, 40)];
    self.shopTypeView.delegate = self;
    [self.view addSubview:self.shopTypeView];

    [self getCateData];
    [self getShopData];
    [self.shopTable reloadData];
}

- (void)setupNav{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 32)];
    [titleView addSubview:self.left];
    [titleView addSubview:self.right];
    [self onSegSelected:self.left];
    self.navigationItem.titleView = titleView;
}

- (void)getCateData{
    [MTShopService cateDataWithScuccess:^(id data) {
        self.cateData = data;
        self.choseView.shopTypeItems = data;
    } Failure:^(NSError *error) {

    }];
}

- (void)getShopData{
    [MTShopService shopDataWithScuccess:^(id data) {
        self.shopData = data;
        [self.shopTable reloadData];
    } Failure:^(NSError *error) {

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - segment delegate
- (void)onSegSelected:(MTShopChooseBtn*)sender{
    if (self.lastSelBtn == sender) {
        return;
    }
    self.lastSelBtn.selected = NO;
    self.lastSelBtn = sender;
    self.lastSelBtn.selected = YES;
}


#pragma mark - 商品类型、区域、距离选择的代理
- (void)onItemTouched:(NSInteger)index{
    if (index == 0) {
        if (self.cateData!=nil) {
            if (self.shopTypeView.lastSelBtn.selected) {
                [self.choseView pop];
            }
            else{
                [self.choseView unPop];
            }
        }
    }
}

#pragma mark - table delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.shopData) {
        return self.shopData.count;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MTShopCell *cell = [MTShopCell cellWithTableView:tableView];
    MTShopItem *item = self.shopData[indexPath.row];
    cell.item = item;
    return cell;
}

#pragma mark - 修正 cell separator
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - kvo mtshopchooseview open属性的监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"open"]) {
        //通知改变shopTypeView选中状态
        self.shopTypeView.lastSelBtn.selected = self.choseView.open;
    }
}

#pragma mark - 懒加载
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

- (MTShopChooseView*)choseView{
    if (!_choseView) {
        _choseView = [[MTShopChooseView alloc] initWithFrame:CGRectMake(0, 64+40, 0, 0)];
        [_choseView addObserver:self forKeyPath:@"open" options:NSKeyValueObservingOptionNew context:nil];
        [self.view addSubview:_choseView];
    }
    return _choseView;
}

- (UITableView*)shopTable{
    if (!_shopTable) {
        _shopTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.shopTypeView.bottom, kScreenWidth, kScreenHeight - self.shopTypeView.bottom-48) style:UITableViewStylePlain];
        _shopTable.delegate = self;
        _shopTable.rowHeight = MTShopCellH;
        _shopTable.dataSource = self;
        [self.view addSubview:_shopTable];
    }
    return _shopTable;
}

#pragma mark - dealloc
- (void)dealloc{
    [self.choseView removeObserver:self forKeyPath:@"open"];
}


@end
