//
//  BaseColorHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseColorHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) UIView *colorView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIView *lineView;

@end

NS_ASSUME_NONNULL_END
