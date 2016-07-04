//
//  ZJFRouteCell.m
//  Travel
//
//  Created by qf1 on 16/1/26.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
// cell的缩放比例
#define kScale 0.5
#define kLabelScale 0.15
#import "DetailViewController.h"
#import "HomeViewController.h"
#import "ZJFRouteCell.h"
//在ARC环境下使用选择器会报警
//加上一下几句话可以去除警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@interface ZJFRouteCell ()

@property (nonatomic, strong) UIImageView *leftView;
@property (nonatomic, strong) UIImageView *rightView;
@property (nonatomic, strong) UIImageView *bigView;
@property (nonatomic, strong) UILabel *leftTitle;
@property (nonatomic, strong) UILabel *rightTitle;
@property (nonatomic, strong) UILabel *bigTitle;

@property (nonatomic, strong) NSMutableArray *viewsArray;
@property (nonatomic, strong) NSMutableArray *labelsArray;
@property (nonatomic, strong) NSArray *modelArray;

@property (nonatomic, strong) HomeViewController *homeVc;
@end

@implementation ZJFRouteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.viewsArray = [[NSMutableArray alloc] init];
        self.labelsArray = [[NSMutableArray alloc] init];
        [self makeUI];
    }
    
    return self;
}


#pragma mark - 创建UI
- (void)makeUI
{
    // x间距
    CGFloat marginX = 2;
    // y间距
    CGFloat marginY = 2;
    // 每个视图宽高
    CGFloat w = (kScreenWidth - marginX * 3)/2;

    CGFloat h = (kScreenHeight*kScale - 3*marginX)/2;
    
    _leftView = [[UIImageView alloc] initWithFrame:CGRectMake(marginX, marginY, w, h)];
    _leftView.tag = 100;
    _leftView.userInteractionEnabled = YES;
    _leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_leftView.frame) - h * kLabelScale, w, h * kLabelScale)];
    [_leftView addSubview:_leftTitle];
    
    _rightView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftView.frame) + marginX, marginY, w, h)];
    _rightView.tag = 101;
    _rightView.userInteractionEnabled = YES;
    _rightTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_rightView.frame) - h * kLabelScale, w, h * kLabelScale)];
    [_rightView addSubview:_rightTitle];
    
    _bigView = [[UIImageView alloc] initWithFrame:CGRectMake(marginX, CGRectGetMaxY(_leftView.frame) + marginY, kScreenWidth - marginX * 2, h)];
    _bigView.tag = 102;
    _bigView.userInteractionEnabled = YES;
    _bigTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_leftView.frame) - h * kLabelScale, kScreenWidth - marginX * 2, h * kLabelScale)];
    [_bigView addSubview:_bigTitle];
    
    [self.labelsArray addObjectsFromArray:@[_leftTitle,_rightTitle,_bigTitle]];
    [self.viewsArray addObjectsFromArray:@[_leftView,_rightView,_bigView]];
    // 添加手势
    for (int i=0; i<self.viewsArray.count; i++) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        [self.viewsArray[i] addGestureRecognizer:tap];
        
        [self.contentView addSubview:self.viewsArray[i]];
    }
    
}


#pragma mark - 添加手势

- (void)tapAction:(UITapGestureRecognizer *)tap
{
//    UIImageView *imageView = (UIImageView *)tap.view;
//    NSInteger page = imageView.tag - 100;
    
    RouteItemsList *model = self.modelArray[0];

    if ([self.target respondsToSelector:self.action]) {
        
        [self.target performSelector:self.action withObject:model.url];
        
    }
    
}


#pragma mark - 设置cell
- (void)setCellWithModel:(RouteModel *)routeModel target:(id)target action:(SEL)action;
{
    self.target = target;
    self.action = action;
    
    self.modelArray = routeModel.itemsList;

    RouteItemsList *model = self.modelArray[0];

    for (int i=0; i<self.viewsArray.count; i++) {

        [self.viewsArray[i] sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@""]];
        
        UILabel *label = self.labelsArray[i];
        label.backgroundColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = model.title;
        
    }
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end












