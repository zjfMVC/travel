//
//  ZJFDetailCell.m
//  Travel
//
//  Created by qf1 on 16/1/28.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#define kCateryScale 0.27
#define kNameScale  0.3
#define kSnameScale 0.2
#define kPriceScale 0.3
#define kAdScale 0.15
#import "DetailModel.h"
#import "ZJFDetailCell.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@interface ZJFDetailCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *snameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *adLabel;

@property (nonatomic, strong) UIButton *collectionButton;

@property (nonatomic, strong) DetailModel *detailModel;


@end

@implementation ZJFDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}


#pragma mark - 创建UI
- (void)makeUI
{
    // 顶部的间隙
    CGFloat marginY = 2;
    // 距离左右的间隙
    CGFloat marginX = 5;
    CGFloat x = marginX;
    CGFloat y = marginY;
    CGFloat w = kScreenWidth - marginX * 2;
    // 整个cell的高度
    CGFloat h = kScreenHeight * kCateryScale;
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h * kNameScale)];
    _nameLabel.numberOfLines = 0;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    
    _snameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_nameLabel.frame) , w, h * kSnameScale)];
    _snameLabel.numberOfLines = 0;
    _snameLabel.textAlignment = NSTextAlignmentCenter;
    _snameLabel.font = [UIFont systemFontOfSize:15];
    _snameLabel.textColor = [UIColor redColor];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_snameLabel.frame) , w * 0.75, h * kPriceScale)];
    
    _collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_priceLabel.frame), CGRectGetMaxY(_snameLabel.frame), w * 0.25, h * kPriceScale)];
    [_collectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    [_collectionButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [_collectionButton setImage:[UIImage imageNamed:@"tab_c1.png"] forState:UIControlStateSelected];
    _collectionButton.tag = 100;
    
    _adLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_priceLabel.frame) , w, h * kAdScale)];
    _adLabel.font = [UIFont systemFontOfSize:15];
    _adLabel.textColor = [UIColor orangeColor];
    
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_snameLabel];
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:_collectionButton];
    [self.contentView addSubview:_adLabel];
    
}


#pragma mark - 按钮点击
- (void)buttonAction:(UIButton *)button
{
    if ([self.target respondsToSelector:self.action]) {
        
        [self.target performSelector:self.action withObject:_detailModel withObject:button];
    }
}


#pragma mark - 设置cell
- (void)setDetailCellWithModel:(DetailModel *)detailModel target:(id)target action:(SEL)action isSelected:(BOOL)isSelected
{
    _target = target;
    _action = action;
    _isSelected = isSelected;
    _detailModel = detailModel;
    _collectionButton.selected = _isSelected;
    
    _nameLabel.text = detailModel.product_name;
    _snameLabel.text = detailModel.sub_name;
    _adLabel.text = detailModel.appoffer;
    
    // 设置一个了label中不同的字体
    NSString *str = [NSString stringWithFormat:@"￥%@/人  (已有%@人报名)",detailModel.price,detailModel.people];
    
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range = NSMakeRange(0, [[muStr string] rangeOfString:@"("].location);
    
    [muStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [muStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range];
    
    [_priceLabel setAttributedText:muStr];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end







