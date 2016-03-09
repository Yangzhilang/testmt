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
#import <YYCategories/YYCGUtilities.h>
#import "MTHomeService.h"

@interface MTHomeController ()

@property(nonatomic,strong)NSArray *discountData;

@end

@implementation MTHomeController
@synthesize tableView = _tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.tableView reloadData];
    //加载折扣
    [self loadDiscount];
}

- (void)loadDiscount{
    [MTHomeService discountDataWithSuccess:^(NSArray *data) {
        self.discountData = data;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"dicount request fail");
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
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
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kHomeMenuViewH;
    }
    else if (indexPath.section == 1){
        return kHomeDiscountViewH;
    }
    return 44;
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
//        homedisView.backgroundColor = [UIColor blueColor];
        [cell.contentView addSubview:homedisView];
    }
    return cell;
}




@end
