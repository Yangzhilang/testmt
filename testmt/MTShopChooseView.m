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
@property(nonatomic,strong)UIView *dragView;
@property(nonatomic,assign)BOOL canMove;

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
    frame.size.height = 0;
    frame.origin.x = 0;
    self = [super initWithFrame:frame];
    self.backgroundColor = UIColorRGB(217, 217, 217);
    if (self) {
        self.dragView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        self.dragView.backgroundColor = [MTGloblesTool themeColor];
        [self addSubview:self.dragView];
        self.lastSelRow = -1;
        _canMove = false;
    }
    return self;
}

- (void)pop{
    if (self.shopTypeItems) {
        NSInteger count = self.shopTypeItems.count;
        if (count>9) {
            count = 9;
        }
        _leftTable.height = 0;
        [_leftTable reloadData];
        self.open = YES;
        [UIView animateWithDuration:.3 animations:^{
            _leftTable.height = count * 44;
            self.height = _leftTable.height+20;
            self.dragView.top = _leftTable.bottom;
            self.dragView.height = 20;
        }];
    }
}

- (void)unPop{
    self.open = NO;
    [UIView animateWithDuration:.2 animations:^{
        _leftTable.height = 0;
        _rightTable.height = 0;
        self.height = 0;
        self.dragView.top = 0;
        self.dragView.height = 0;
    }];
}

- (void)setShopTypeItems:(NSArray *)shopTypeItems{
    _shopTypeItems = shopTypeItems;
    [self.leftTable reloadData];
    [self.rightTable reloadData];
}

#pragma mark - touch事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    if (CGRectContainsPoint(self.dragView.frame, location)) {
        self.canMove = YES;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_canMove) {
        UITouch *touch = touches.anyObject;
        CGPoint location = [touch locationInView:self];
        CGPoint preLocation = [touch previousLocationInView:self];
        CGFloat offset = location.y - preLocation.y;
        CGFloat height = self.height + offset;
        CGFloat maxH = 44 * 9 + 20;
        if (height > maxH || height < 50) {
            return;
        }
        self.height = height;
        self.leftTable.height += offset;
        self.rightTable.height = self.leftTable.height;
        self.dragView.top += offset;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _canMove = NO;
    CGFloat maxH = 44 * 9 + 20;
    if (self.height < maxH) {
        [self unPop];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _canMove = NO;
    CGFloat maxH = 44 * 9 + 20;
    if (self.height < maxH) {
        [self unPop];
    }
}


#pragma mark -
#pragma mark - table delegate and datasource
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
            cell.preservesSuperviewLayoutMargins = NO;
        }
        MTShopTypeItem *item = (MTShopTypeItem*)self.shopTypeItems[indexPath.row];
        cell.textLabel.text = item.name;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        return cell;
    }
    else{
        NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.preservesSuperviewLayoutMargins = NO;
            cell.backgroundColor = UIColorRGB(217, 217, 217);
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:12];

            cell.accessoryView = label;
        }
        MTShopTypeItem *item = (MTShopTypeItem*)self.shopTypeItems[self.lastSelRow];
        MTShopTypeItem *detailItem = item.list[indexPath.row];
        cell.textLabel.text = detailItem.name;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        UILabel *label = (UILabel*)cell.accessoryView;
        label.text = [NSString stringWithFormat:@"%ld",detailItem.count];
        [label sizeToFit];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MTShopTypeItem *item = (MTShopTypeItem*)self.shopTypeItems[indexPath.row];
    if (tableView == self.leftTable) {
        if (item.list) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.textColor = [MTGloblesTool themeColor];
            self.lastSelRow = indexPath.row;
            self.rightTable.height = self.leftTable.height;
            [self.rightTable reloadData];
        }
        else{

        }
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
#pragma mark - 懒加载

- (UITableView*)leftTable{
    if (!_leftTable) {
        _leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth*.3, 0)];
        _leftTable.dataSource = self;
        _leftTable.delegate = self;
        _leftTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

        [self addSubview:_leftTable];
    }
    return _leftTable;
}

- (UITableView*)rightTable{
    if (!_rightTable) {
        _rightTable = [[UITableView alloc] initWithFrame:CGRectMake(self.leftTable.right, 0, kScreenWidth*.7, 0)];
        _rightTable.delegate = self;
        _rightTable.dataSource = self;
        _rightTable.backgroundColor = UIColorRGB(217, 217, 217);
        [self addSubview:_rightTable];
    }
    return _rightTable;
}

@end
