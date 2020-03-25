//
//  UITableView+EmptyData.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (EmptyData)

- (void)tableViewDisplayWitMessage:(NSString *)message Img:(NSString *)img ifNecessaryForRowCount:(NSUInteger)rowCount;

@end

NS_ASSUME_NONNULL_END
