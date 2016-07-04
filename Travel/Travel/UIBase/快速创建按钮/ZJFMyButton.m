//
//  ZJFMyButton.m
//  工具类
//
//  Created by qf1 on 16/1/7.
//  Copyright © 2016年 qf1. All rights reserved.
//

#import "ZJFMyButton.h"

@implementation ZJFMyButton

+ (instancetype)createBlockButtonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName backImageName:(NSString *)backImageName tag:(int)tag actionBlock:(MyBlock)actionBlock
{
    ZJFMyButton *button = [ZJFMyButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    // 给self的属性代码块赋值
    button.myBlock = actionBlock;
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


//2016-01-14 16:58:28.111[40892:1720071] +[ZJFMyButton buttonAction:]: unrecognized selector sent to class 0x1027a58e8
// 如果这里写成对象方法就会崩溃，解决方法写成类方法
+ (void)buttonAction:(ZJFMyButton *)button
{
    if (button.myBlock) {
        // 代码块回调
        button.myBlock(button);
    }
}
@end








