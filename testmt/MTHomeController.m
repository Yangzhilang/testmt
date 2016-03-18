//
//  MTHomeController.m
//  testmt
//
//  Created by yzl on 16/3/4.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTHomeController.h"
#import "MTHomeMenu.h"
#import "MTHomeDiscountView.h"
#import "MTHomeService.h"
#import "MTGuessYLikeCell.h"
#import "MTCityButton.h"
#import "MTHomeSearchBtn.h"
#import "MTCitySearchController.h"
#import "MTCodeController.h"
#import "MTRefreshHeader.h"
#import <MJRefresh.h>

@interface MTHomeController ()

@property(nonatomic,strong)MTCityButton *cityButton;
@property(nonatomic,strong)MTHomeSearchBtn *searchBtn;

@property(nonatomic,strong)NSArray *discountData;
@property(nonatomic,strong)NSArray *gulData;

@end

@implementation MTHomeController
@synthesize tableView = _tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setUpNavBar];
    [self.tableView reloadData];
    [self loadGifRefresh];
}

- (void)loadGifRefresh{
    DWEAKSELF
    MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDiscount];
        [weakSelf loadGueeYLike];
    }];
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}

- (void)setUpNavBar{

    UINavigationBar *bar = self.navigationController.navigationBar;
    [bar setBackgroundImage:[UIImage imageWithColor:[MTGloblesTool themeColor]] forBarMetrics:UIBarMetricsDefault];

    self.searchBtn = [MTHomeSearchBtn searchBtn];
    self.navigationItem.titleView = self.searchBtn;

    self.cityButton = [MTCityButton cityBtn];
    [self.cityButton addTarget:self action:@selector(onCityTouched:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.cityButton];

    UIButton *qrcodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qrcodeBtn setImage:[UIImage imageNamed:@"icon_homepage_scan"] forState:UIControlStateNormal];
    [qrcodeBtn setImage:[UIImage imageNamed:@"icon_homepage_scan_pressed"] forState:UIControlStateSelected];
    qrcodeBtn.frame = CGRectMake(0, 0, 20, 20);
    [qrcodeBtn addTarget:self action:@selector(onQRcodeTouched:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:qrcodeBtn];
}

- (void)loadDiscount{
    [MTHomeService discountDataWithSuccess:^(NSArray *data) {
        self.discountData = data;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadGueeYLike{
    [MTHomeService guessYouLikeDataWithScueess:^(NSArray *data) {
        self.gulData = data;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - city touched

- (void)onCityTouched:(UIButton*)sender{
  
    [self.navigationController presentViewController:[MTCitySearchController controllerWithParent:self] animated:YES completion:nil];
}

#pragma mark - qrcode touched

- (void)onQRcodeTouched:(UIButton*)sender{
    MTCodeController *ctr = [[MTCodeController alloc] init];
//    [self.navigationController pushViewController:ctr animated:YES];
//    [self.navigationController present]
    [self presentViewController:ctr animated:YES completion:nil];
}

#pragma mark - tableView method

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - tableview delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    int count = 1;
    if (self.discountData && self.discountData.count) {
        count++;
    }
    if (self.gulData && self.gulData.count) {
        count++;
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return self.gulData.count+1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kHomeMenuViewH;
    }
    else if (indexPath.section == 1){
        return kHomeDiscountViewH;
    }
    else if (indexPath.section == 2){
        if (indexPath.row==0) {
            return 33;
        }
        return MTGuessYLikeCellH;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return .1;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 0)];
    view.backgroundColor = UIColorRGB(239, 239, 244);
    return view;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 0)];
    view.backgroundColor = UIColorRGB(239, 239, 244);
    return view;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        NSString *identifier = @"menucell";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            MTHomeMenu *homeMenu = [[MTHomeMenu alloc] init];
            [cell.contentView addSubview:homeMenu];
        }
    }
    else if (indexPath.section ==1){
        NSString *identifier = @"discountcell";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            MTHomeDiscountView *homedisView = [[MTHomeDiscountView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , kHomeDiscountViewH)];
            homedisView.items = self.discountData;
            [cell.contentView addSubview:homedisView];
        }
    }
    else if (indexPath.section == 2){
        if (indexPath.row == 0){
            NSString *identifier = @"guessyoulikecell1";
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.textLabel.text = @"猜你喜欢";
        }
        else{
            MTGuessYLikeCell *gluCell = [MTGuessYLikeCell cellWithTableView:tableView];
            MTGuessYLikeItem *item = self.gulData[indexPath.row-1];
            gluCell.item = item;
            return gluCell;
        }
    }
    return cell;
}

- (void)setCity:(NSString *)city{
    if (city==nil) {
        return;
    }
    [self.cityButton setTitle:city forState:UIControlStateNormal];
}
@end
