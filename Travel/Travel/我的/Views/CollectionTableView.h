//
//  CollectionTableView.h
//  Travel
//
//  Created by qf1 on 16/2/21.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CollectionBlock)(NSIndexPath *indexPath);

@interface CollectionTableView : UITableView

- (void)customWithArray:(NSArray *)dataArray complimentBlock:(CollectionBlock)block;
@end
