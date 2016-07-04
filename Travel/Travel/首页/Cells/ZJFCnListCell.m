//
//  ZJFCnListCell.m
//  Travel
//
//  Created by qf1 on 16/1/28.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#define kCateryScale 0.25
// label缩放比例
#define kLabelScale 0.15

#import "ZJFCnListCell.h"

@interface ZJFCnListCell ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ZJFCnListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}


#pragma mark - 创建UI
- (void)makeUI
{
    // y方向的间隙
    CGFloat marginY = 1;
    // x方向的间隙
    CGFloat marginX = 2;
    CGFloat x = marginX;
    CGFloat y = marginY;
    CGFloat w = kScreenWidth - marginX * 2;
    CGFloat h = kScreenHeight * kCateryScale - marginY * 2;
    // label的高度
    CGFloat labelH = h * kLabelScale;
    _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [self.contentView addSubview:_backImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginX, CGRectGetMaxY(_backImageView.frame) - labelH, w, labelH)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor lightGrayColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_titleLabel];
}


#pragma mark - 设置cell
- (void)setModelWithItemsModel:(CnListItemsList *)model;
{
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@""]];
    
    _titleLabel.text = model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end







