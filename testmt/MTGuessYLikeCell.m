//
//  MTGuessYLikeCell.m
//  testmt
//
//  Created by yzl on 16/3/10.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTGuessYLikeCell.h"
#import "MTGloblesTool.h"
#import <UIImageView+WebCache.h>
#import "MTGuessYLikeItem.h"

#define Padding1 5
#define Padding2 10

@interface MTGuessYLikeCell ()

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,strong)UIImageView *storeIcon;
@property(nonatomic,strong)UILabel *storeLabel;
@property(nonatomic,strong)UILabel *storeSecLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *priceSecLabel;

@end

@implementation MTGuessYLikeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = @"guessylike";
    MTGuessYLikeCell *cell = (MTGuessYLikeCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MTGuessYLikeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setItem:(MTGuessYLikeItem *)item{
    _item = item;
    [self.storeIcon sd_setImageWithURL:_item.imageurl placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    self.storeLabel.text = _item.mname;
    self.storeSecLabel.text = _item.dtitle;
    self.priceLabel.text = [NSString stringWithFormat:@"%ld",_item.price];
    self.priceSecLabel.text = [NSString stringWithFormat:@"%ld",_item.price];
}

- (UIImageView*)storeIcon{
    if (!_storeIcon) {
        _storeIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:_storeIcon];
        [_storeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@(Padding1));
            make.top.mas_equalTo(@(Padding2));
            make.size.mas_equalTo(CGSizeMake(65, 65));
        }];
    }
    return _storeIcon;
}

- (UILabel*)storeLabel{
    if (!_storeLabel) {
         UIView *leftView = self.storeIcon;
        _storeLabel = [[UILabel alloc] init];
        _storeLabel.font = [UIFont systemFontOfSize:15];
        _storeLabel.textColor = [UIColor blackColor];
        [_storeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right).with.offset(Padding1);
            make.top.equalTo(leftView);
            make.width.mas_equalTo(@(10));
            make.height.mas_equalTo(@10);
        }];
        [self.contentView addSubview:_storeLabel];
    }
    return _storeLabel;
}

- (UILabel*)storeSecLabel{
    if (!_storeSecLabel) {
        __weak UIView *topView = self.storeLabel;
        __weak UIView *bottomView = self.priceLabel;
        __weak UIView *contentView = self.contentView;
        _storeSecLabel = [[UILabel alloc] init];
        _storeSecLabel.font =[UIFont systemFontOfSize:12];
        _storeSecLabel.textColor = [UIColor lightGrayColor];
        [_storeSecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topView);
            make.right.equalTo(contentView).with.offset(-Padding2);
            make.height.mas_equalTo(@(20));
            make.centerY.mas_equalTo(@((bottomView.centerY+topView.centerY)/2));
        }];
        [self.contentView addSubview:_storeSecLabel];
    }
    return _storeSecLabel;
}

- (UILabel*)priceLabel{
    if (!_priceLabel) {
        __weak UIView* leftView = self.storeIcon;
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor = [MTGloblesTool themeColor];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView).width.offset(Padding2);
            make.bottom.equalTo(leftView);
            make.width.mas_equalTo(@30);
        }];
        [self.contentView addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (UILabel*)priceSecLabel{
    if (!_priceSecLabel) {
        __weak UIView* leftView = self.priceSecLabel;
        _priceSecLabel = [[UILabel alloc] init];
        _priceSecLabel.font = [UIFont systemFontOfSize:12];
        _priceSecLabel.textColor = [MTGloblesTool themeColor];
        [_priceSecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView).width.offset(Padding1);
            make.bottom.equalTo(leftView);
            make.width.mas_equalTo(@30);
        }];
        [self.contentView addSubview:_priceSecLabel];
    }
    return _priceSecLabel;
}

@end
