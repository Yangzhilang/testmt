//
//  MTShopCell.m
//  testmt
//
//  Created by yzl on 16/3/23.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTShopCell.h"
#import "MTShopItem.h"
#import <UIImageView+WebCache.h>

#define Padding1 5
#define Padding2 10

#define ImageH 70
#define ImageW 90

#define StarH 13

@interface MTShopCell ()

@property(nonatomic,strong)UIImageView *frontImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIView *scoreView; ///<星星
@property(nonatomic,strong)UILabel *markLabel;
@property(nonatomic,strong)UILabel *averPriceLabel;
@property(nonatomic,strong)UILabel *cateLabel; ///<例如 西北草 车公庙

@end

@implementation MTShopCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = @"cell";
    MTShopCell *cell = (MTShopCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MTShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.preservesSuperviewLayoutMargins = NO;
    }
    return cell;
}

- (void)setItem:(MTShopItem *)item{
    _item = item;

    [self.frontImageView sd_setImageWithURL:item.frontImg placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    self.nameLabel.text = item.name;
    [self setActiveStar];
    self.markLabel.text = [NSString stringWithFormat:@"%ld评价",item.markNumbers];
    self.averPriceLabel.text = [NSString stringWithFormat:@"人均￥%.0f",item.avgPrice];
    self.cateLabel.text = [NSString stringWithFormat:@"%@ %@",item.cateName,item.areaName];
}

- (void)setActiveStar{
    BOOL empty = self.item.markNumbers?NO:YES;
    float allStar = self.item.avgScore;
    int index = 0;
    for (UIImageView* star in self.scoreView.subviews) {
        if (empty) {
            star.image = [UIImage imageNamed:@"icon_merchant_star_empty"];
        }
        else{
            if (index-allStar<0 && index-allStar>-1) {
                star.image = [UIImage imageNamed:@"icon_merchant_rating_star_half"];
            }
            else if (index-allStar<0){
                star.image = [UIImage imageNamed:@"icon_merchant_rating_star_picked"];
            }
            else{
                star.image = [UIImage imageNamed:@"icon_merchant_rating_star_not_picked"];
            }
        }
        index++;
    }
}

#pragma 懒加载
- (UIImageView*)frontImageView{
    if (!_frontImageView) {
        _frontImageView = [[UIImageView alloc] init];
        _frontImageView.layer.cornerRadius = 5;
        _frontImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_frontImageView];
        [_frontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Padding2);
            make.size.mas_equalTo(CGSizeMake(ImageW, ImageH));
            make.top.mas_equalTo(Padding2);
        }];
    }
    return _frontImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        DWEAKSELF
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.frontImageView.mas_right).with.offset(Padding2);
            make.top.mas_equalTo(Padding2);
            make.right.mas_lessThanOrEqualTo(-60);
            make.height.mas_equalTo(StarH);
        }];
    }
    return _nameLabel;
}

- (UIView*)scoreView{
    if (!_scoreView) {
        DWEAKSELF
        _scoreView = [[UIView alloc] init];
        [self.contentView addSubview:_scoreView];
        [_scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.frontImageView.mas_right).with.offset(Padding2);
            make.centerY.equalTo(weakSelf.contentView);
            make.size.mas_equalTo(CGSizeMake((StarH+2)*5, StarH));
        }];
        [self createFiveStar];
    }
    return _scoreView;
}

- (void)createFiveStar{
    CGFloat offset = 0;
    for (int i = 0; i<5; i++) {
        UIImageView *star = [[UIImageView alloc] init];
        [_scoreView addSubview:star];
        [star mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(StarH, StarH));
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(offset);
        }];
        offset += 2+StarH;
    }
}

- (UILabel*)markLabel{
    if (!_markLabel) {
        DWEAKSELF
        _markLabel = [[UILabel alloc] init];
        _markLabel.font = [UIFont systemFontOfSize:12];
        _markLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_markLabel];
        [_markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.scoreView.mas_right).with.offset(Padding1);
            make.centerY.equalTo(weakSelf.contentView);
            make.width.mas_greaterThanOrEqualTo(20);
            make.height.mas_equalTo(20);
        }];
    }
    return _markLabel;
}

- (UILabel*)averPriceLabel{
    if (!_averPriceLabel) {
        DWEAKSELF
        _averPriceLabel = [[UILabel alloc] init];
        _averPriceLabel.font = [UIFont systemFontOfSize:12];
        _averPriceLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_averPriceLabel];
        [_averPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-Padding2);
            make.width.mas_greaterThanOrEqualTo(20);
            make.height.mas_equalTo(20);
            make.centerY.equalTo(weakSelf.contentView);
        }];
    }
    return _averPriceLabel;
}

- (UILabel*)cateLabel{
    if (!_cateLabel) {
        DWEAKSELF
        _cateLabel = [[UILabel alloc] init];
        _cateLabel.font = [UIFont systemFontOfSize:12];
        _cateLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_cateLabel];
        [_cateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.frontImageView.mas_right).with.offset(Padding2);
            make.bottom.equalTo(weakSelf.frontImageView);
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
    }
    return _cateLabel;
}

@end
