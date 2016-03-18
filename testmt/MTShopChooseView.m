//
//  MTShopChooseView.m
//  testmt
//
//  Created by yzl on 16/3/16.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTShopChooseView.h"
#import "MTShopTypeItem.h"

#define defaultH 10

@interface MTShopChooseView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign)NSInteger lastSelRow;

@end

@implementation MTShopChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame{
    frame.size.width = kScreenWidth;
    frame.size.height = defaultH;
    frame.origin.x = 0;
    self = [super initWithFrame:frame];
    if (self) {

        self.lastSelRow = -1;
    }
    return self;
}

- (UITableView*)leftTable{
    if (!_leftTable) {
        _leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _leftTable.dataSource = self;
        _leftTable.delegate = self;
        [self addSubview:_leftTable];
    }
    return _leftTable;
}

- (UITableView*)rightTable{
    if (!_rightTable) {
        _rightTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _rightTable.delegate = self;
        _rightTable.dataSource = self;
        [self addSubview:_rightTable];
    }
    return _rightTable;
}

- (void)setShopTypeItems:(NSArray *)shopTypeItems{
    _shopTypeItems = shopTypeItems;
    [self.leftTable reloadData];
    [self.rightTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.leftTable == tableView) {
        if (self.shopTypeItems) {
            return self.shopTypeItems.count;
        }
    }
    else{
        if (self.lastSelRow >0 && self.shopTypeItems && self.shopTypeItems.count > self.lastSelRow) {
            MTShopTypeItem *item = (MTShopTypeItem*)self.shopTypeItems[self.lastSelRow];
            if (item.list) {
                return item.list.count;
            }
        }
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) {
        NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        MTShopTypeItem *item = (MTShopTypeItem*)self.shopTypeItems[indexPath.row];
        cell.textLabel.text = item.name;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
    else{
        NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.backgroundColor = [UIColor lightTextColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:14];
            cell.accessoryView = label;
        }
        MTShopTypeItem *item = (MTShopTypeItem*)self.shopTypeItems[self.lastSelRow];
        MTShopTypeItem *detailItem = item.list[indexPath.row];
        cell.textLabel.text = detailItem.name;
        UILabel *label = (UILabel*)cell.accessoryView;
        label.text = [NSString stringWithFormat:@"%ld",detailItem.count];
        [label sizeToFit];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [MTGloblesTool themeColor];
    }
    else{
        
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor blackColor];
    }
}



@end
