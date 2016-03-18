//
//  MTCitySearchController.m
//  testmt
//
//  Created by yzl on 16/3/11.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTCitySearchController.h"
#import "MTHomeService.h"
#import "MTHomeController.h"

@interface MTCitySearchController ()<UISearchBarDelegate,UISearchDisplayDelegate>

@property(nonatomic,strong)NSArray *cityData;
@property(nonatomic,strong)NSArray *resultList;
@property(nonatomic,strong)UISearchDisplayController *searchCtr;

@end

@implementation MTCitySearchController

+(UIViewController*)controllerWithParent:(MTHomeController *)parent{
    MTCitySearchController *ctr = [[MTCitySearchController alloc] initWithStyle:UITableViewStylePlain];
    ctr.parent = parent;
    ctr.title = @"当前城市-成都";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ctr
                                   ];
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.searchCtr.searchBar;
    [self loadCityData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadCityData{
    [MTHomeService cityDataWithSuccess:^(NSArray *data) {
        self.cityData = data;
        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tableView) {
        if (!self.cityData) {
            return 0;
        }
        return self.cityData.count;
    }
    else{
        if (!self.resultList) {
            return 0;
        }
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        NSArray *a = self.cityData[section];
        return a.count;
    }
    else{
        return self.resultList.count;
    }

}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    char title = 65+section;
    return [NSString stringWithFormat:@"%c",title];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (tableView == self.tableView) {
        NSArray *a = self.cityData[indexPath.section];
        cell.textLabel.text = a[indexPath.row];
    }
    else if (tableView == self.searchDisplayController.searchResultsTableView){
        cell.textLabel.text = self.resultList[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *city;
    if (tableView == self.tableView) {
        NSArray *a = self.cityData[indexPath.section];
        city = a[indexPath.row];
    }
    else{
        city = self.resultList[indexPath.row];
        [self.searchDisplayController.searchBar resignFirstResponder];
    }
    [MTGloblesTool setCity:city];
    [self.parent setCity:city];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UISearchDisplayController*)searchCtr{
    if (!_searchCtr) {
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
        _searchCtr = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        _searchCtr.delegate =self;
        _searchCtr.searchResultsDataSource = self;
        _searchCtr.searchResultsDelegate = self;
    }
    return _searchCtr;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",searchString];
    self.resultList = nil;
    NSMutableArray *list = [NSMutableArray array];
    for (NSArray *section in self.cityData) {
        [list addObjectsFromArray:[section filteredArrayUsingPredicate:predicate]];
    }
    self.resultList = list;

    return YES;
}

@end
