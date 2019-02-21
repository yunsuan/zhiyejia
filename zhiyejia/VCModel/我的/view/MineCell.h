//
//  MineCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineCell : UITableViewCell

@property (nonatomic, strong) UIImageView *titleImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIImageView *rightImg;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
