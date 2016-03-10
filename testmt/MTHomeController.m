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

@interface MTHomeController ()

@property(nonatomic,strong)NSArray *discountData;
@property(nonatomic,strong)NSArray *gulData;

@end

@implementation MTHomeController
@synthesize tableView = _tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView reloadData];
    //加载折扣

    [self loadDiscount];
    [self loadGueeYLike];
}

- (void)loadDiscount{
    [MTHomeService discountDataWithSuccess:^(NSArray *data) {
        self.discountData = data;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

- (void)loadGueeYLike{
    [MTHomeService guessYouLikeDataWithScueess:^(NSArray *data) {
        self.gulData = data;
        [self.tableView reloadData];
    } failure:^(NSError *error) {

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        MTHomeMenu *homeMenu = [[MTHomeMenu alloc] init];
        [cell.contentView addSubview:homeMenu];
    }
    else if (indexPath.section ==1){
        NSString *identifier = @"discountcell";
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        MTHomeDiscountView *homedisView = [[MTHomeDiscountView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , kHomeDiscountViewH)];
        homedisView.items = self.discountData;
        [cell.contentView addSubview:homedisView];
    }
    else if (indexPath.section == 2){
        if (indexPath.row == 0){
            NSString *identifier = @"guessyoulikecell1";
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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




@end
