//
//  ZJFCateryListCell.m
//  Travel
//
//  Created by qf1 on 16/2/3.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
// cell的比例
#define kCellScale 0.3
// bigImageView的比例
#define kBigImageView 0.6
// titleLabel比例
#define kTitleLabel 0.3
// disLabel比例
#define kDisLabel 0.1

#import "ZJFCateryListCell.h"

@interface ZJFCateryListCell ()

@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *disLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end

@implementation ZJFCateryListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}


#pragma mark - 创建UI
- (void)createUI
{
    // x间距
    CGFloat marginX = 5;
    // y间距
    CGFloat marginY = 5;
    CGFloat x = marginX;
    CGFloat y = marginY;
    // 整个cell内容的宽高
    CGFloat w = self.frame.size.width - marginX * 2;
    CGFloat h = self.frame.size.height - marginY * 2;
    
    _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h * kBigImageView)];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_bigImageView.frame), w, h * kTitleLabel)];
    _titleLabel.numberOfLines = 0;
    
    _disLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_titleLabel.frame), w/2, h * kDisLabel)];
    _disLabel.font = [UIFont systemFontOfSize:12];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_disLabel.frame), CGRectGetMaxY(_titleLabel.frame), w/2, h * kDisLabel)];
    _priceLabel.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:_bigImageView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_disLabel];
    [self.contentView addSubview:_priceLabel];
    
}

#pragma mark - 设置模型
- (void)setProductListModel:(ProductListModel *)productListModel
{
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:productListModel.thumb] placeholderImage:[UIImage imageNamed:@""]];
    
    _titleLabel.text = productListModel.product_name;
    
    _disLabel.text = productListModel.place_label;
    // 设置一个了label中不同的字体
    NSString *str = [NSString stringWithFormat:@"%@元起%@",productListModel.price,productListModel.days];
    
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range = NSMakeRange(0, [[muStr string] rangeOfString:@"元"].location);

    [muStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [muStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range];
    
    [_priceLabel setAttributedText:muStr];
    
    
}

@end




































