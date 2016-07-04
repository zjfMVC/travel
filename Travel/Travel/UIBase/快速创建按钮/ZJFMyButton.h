//
//  ZJFMyButton.h
//  工具类
//
//  Created by qf1 on 16/1/7.
//  Copyright © 2016年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJFMyButton;
//定义代码块类型
typedef void(^MyBlock) (ZJFMyButton *myButton);

@interface ZJFMyButton : UIButton

@property (nonatomic, copy) MyBlock myBlock;

+ (instancetype)createBlockButtonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName backImageName:(NSString *)backImageName tag:(int)tag actionBlock:(MyBlock )actionBlock;

@end
