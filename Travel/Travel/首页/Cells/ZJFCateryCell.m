//
//  ZJFCateryCell.m
//  Travel
//
//  Created by qf1 on 16/1/26.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
// 缩放比例
#define kScale 0.1
// 视图大小
#define kViewW 40
#define kViewH 40
// 一行多少个
#define kNumber 4
// 总共个数
#define kSize 8
// 状态栏
#define kStart 0
// y中的间距
#define kMarginY 20
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

#import "ZJFCateryCell.h"

@interface ZJFCateryCell ()

@property (nonatomic, strong) NSArray *modelArray;
@end

@implementation ZJFCateryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self makeUI];
    }
    
    return self;
}

#pragma mark - 创建UI
- (void)makeUI
{
    // x间距
    CGFloat marginX = (kScreenWidth - (kViewW * kNumber)) / (kNumber + 1);
    // y间距
    CGFloat marginY = kMarginY;
    
    
    for (int i=0; i<kSize; i++) {
        // 当前行中的第几个
        int row = i %  kNumber;
        
        // 第几行(在当前列中的第几个)
        int low = i / kNumber;
        
        CGFloat x = marginX + (kViewW + marginX) * row;
        CGFloat y = kStart + marginY + (kViewH + marginY) * low;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, kViewW, kViewH);
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
        UILabel *lable = [[UILabel alloc] init];
        lable.tag = 200 + i;
        lable.frame = CGRectMake(x, CGRectGetMaxY(button.frame), kViewW, 20);
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:lable];
        
    }

}

#pragma mark - 设置cell
// 设置cell
- (void)setCellWithModel:(NavsModel *)navsModel target:(id)target action:(SEL)action;
{
    self.target = target;
    self.action = action;
    self.modelArray = navsModel.itemsList;
    
    for (int i=0; i<navsModel.itemsList.count; i++) {
        // 获取模型
        ItemsList *model = self.modelArray[i];
        
        UIButton *button = (UIButton *)[self.contentView viewWithTag:100+i];
        
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.thumb] forState:UIControlStateNormal];
        
        UILabel *label = (UILabel *)[self.contentView viewWithTag:200+i];
        
        label.text = model.title;
    }
    
}
// 按钮点击事件
- (void)buttonClick:(UIButton *)button
{
    NSInteger num = button.tag - 100;
    ItemsList *model = self.modelArray[num];
    
    if ([self.target respondsToSelector:self.action]) {
        
        [self.target performSelector:self.action withObject:model];
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























