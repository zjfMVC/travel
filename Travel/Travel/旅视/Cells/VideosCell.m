//
//  VideosCell.m
//  Travel
//
//  Created by qf1 on 16/2/4.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
// nameLabel比例
#define kNameLabel 0.15
// snameLabel比例
#define kSnameLabel 0.15
// titleLabel比例
#define kTitleLabel 0.15
// cell的缩放比例
#define kVideosScale 0.3
#import "VideosCell.h"
@interface VideosCell ()

@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *snameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@end


@implementation VideosCell

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
    CGFloat marginY = 5;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = kScreenWidth;
    CGFloat h = kScreenHeight * kVideosScale - marginY;
    
    _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_bigImageView.frame)/2, w, h * kNameLabel)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont boldSystemFontOfSize:17];
    
    _snameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_nameLabel.frame), w, h * kSnameLabel)];
    _snameLabel.textAlignment = NSTextAlignmentCenter;
    _snameLabel.textColor = [UIColor whiteColor];
    _snameLabel.font = [UIFont systemFontOfSize:12];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((w - w * kTitleLabel)/2, CGRectGetMinY(_nameLabel.frame) - h * kTitleLabel, w * kTitleLabel, h * kTitleLabel)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.highlightedTextColor = [UIColor grayColor];
    
    [self.contentView addSubview:_bigImageView];
    
    [_bigImageView addSubview:_nameLabel];
    [_bigImageView addSubview:_snameLabel];
    [_bigImageView addSubview:_titleLabel];
    
    
}


#pragma mark - 设置cell
- (void)setContenModel:(ContentModel *)contenModel
{
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:contenModel.imageHref] placeholderImage:[UIImage imageNamed:@""]];
    
    _nameLabel.text = contenModel.name;
    
    if (contenModel.sightParentName == nil) {
        
        _snameLabel.text = contenModel.sightName;
    } else {
       _snameLabel.text = [NSString stringWithFormat:@"%@/%@",contenModel.sightName,contenModel.sightParentName];
    }
    
    _titleLabel.text = contenModel.tags;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end






