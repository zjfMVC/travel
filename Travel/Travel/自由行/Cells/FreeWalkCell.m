//
//  FreeWalkCell.m
//  Travel
//
//  Created by qf1 on 16/2/17.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
// cell的比例
#define kCellScale 0.3
// bigImageView的比例
#define kBigImageView 0.5
// titleLabel比例
#define kTitleLabel 0.3
#define kTimeLabel 0.1
// disLabel比例
#define kSaleLabel 0.1
#import "FreeWalkCell.h"

@interface FreeWalkCell ()
@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *saleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation FreeWalkCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
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
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_titleLabel.frame), w, h * kTimeLabel)];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor whiteColor];
    
    _saleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_timeLabel.frame), w/2, h * kSaleLabel)];
    _saleLabel.font = [UIFont systemFontOfSize:12];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_saleLabel.frame), CGRectGetMaxY(_timeLabel.frame), w/2, h * kSaleLabel)];
    _priceLabel.font = [UIFont systemFontOfSize:12];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_bigImageView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_saleLabel];
    [self.contentView addSubview:_priceLabel];
    
}

#pragma mark - 设置模型
- (void)setFreeWalkModel:(FreeWalkModel *)freeWalkModel
{
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:freeWalkModel.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    _titleLabel.text = freeWalkModel.title;
    
    _timeLabel.text = freeWalkModel.departureTime;
    _saleLabel.text = [NSString stringWithFormat:@"销量:%@",freeWalkModel.sale_count];
    
    NSString *cutStr = freeWalkModel.price;
    //(NSCharacterSet *)字符集合，用于按多个字符来分割。
    NSArray * array = [cutStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];

    // 设置一个了label中不同的字体
    NSString *str = [NSString stringWithFormat:@"%@元起",array[2]];
    
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range = NSMakeRange(0, [[muStr string] rangeOfString:@"元"].location);
    
    [muStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [muStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range];
    [_priceLabel setAttributedText:muStr];
}

@end










