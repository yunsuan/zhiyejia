//
//  DynamicListCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/19.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DynamicListCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIView *line;
@end

NS_ASSUME_NONNULL_END
