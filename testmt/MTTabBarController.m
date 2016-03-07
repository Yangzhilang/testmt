//
//  MTTabbarController.m
//  testmt
//
//  Created by yzl on 16/3/4.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTTabBarController.h"
#import "MTTabBar.h"
#import "MTHomeController.h"

@interface MTTabBarController ()

@property(nonatomic,weak)MTTabBar *mtTabBar;

@end

@implementation MTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MTTabBar *tabBar = [[MTTabBar alloc] initWithFrame:self.tabBar.bounds];
    [self.tabBar addSubview:tabBar];
    __weak typeof(self) weakSelf = self;
    tabBar.block = ^(NSInteger index){
        weakSelf.selectedIndex = index;
    };
    self.mtTabBar = tabBar;

//    [self loadControllers];

}

//- (void)loadControllers{
//    MTHomeController *homeCtr = [[MTHomeController alloc] init];
//
//    self.viewControllers = @[homeCtr];
//}

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

@end
