//
//  PhotosViewController.m
//  Travel
//
//  Created by qf1 on 16/2/19.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "PhotosViewController.h"

@interface PhotosViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
}


#pragma mark-设置UI
- (void)setUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航栏
    self.title = @"图片详情";
    
    // 设置滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    _scrollView.contentSize = CGSizeMake(_photosArray.count*self.view.frame.size.width, self.view.frame.size.height-64);
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.contentOffset = CGPointMake(self.view.frame.size.width*_index, 0);
    
    [self.view addSubview:_scrollView];
    
    // 添加图片
    for (int i=0; i<_photosArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
        imageView.backgroundColor = [UIColor blackColor];
        imageView.userInteractionEnabled = YES;
        //图片的填充模式 UIViewContentModeScaleAspectFit UIViewContentModeScaleAspectFill
        imageView.contentMode = UIViewContentModeCenter;
        //超出视图本身的裁减掉
        imageView.layer.masksToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:_photosArray[i]] placeholderImage:nil];
        [_scrollView addSubview:imageView];
        
        // 添加长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPress.minimumPressDuration = 1.0;
        [imageView addGestureRecognizer:longPress];
        
    }
}

#pragma mark-手势事件
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    UIImageView *imageView = (UIImageView *)longPress.view;
    
    _imageView = imageView;
    
    if (longPress.state == UIGestureRecognizerStateEnded) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"保存图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存", nil];
        [actionSheet showInView:self.view];
    }
}

#pragma mark-UIActionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.cancelButtonIndex == buttonIndex) {
        return;
    }
    
    UIImageWriteToSavedPhotosAlbum(_imageView.image, nil, nil, nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end















