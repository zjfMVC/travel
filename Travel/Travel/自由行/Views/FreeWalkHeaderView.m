//
//  FreeWalkHeaderView.m
//  Travel
//
//  Created by qf1 on 16/2/17.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "FreeWalkHeaderView.h"

@implementation FreeWalkHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"freeHeader@2x.png"]];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), self.frame.size.width, self.frame.size.height/2)];
        self.subTitleLabel.font = [UIFont systemFontOfSize:15];
        self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_titleLabel];
        
        [self addSubview:_subTitleLabel];
    }
    return self;
}

- (void)setLabelTextWithArray:(NSArray *)array
{
    _titleLabel.text = [array firstObject];
    _subTitleLabel.text = [array lastObject];
}

@end













