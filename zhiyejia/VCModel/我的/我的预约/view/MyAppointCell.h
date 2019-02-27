//
//  MyAppointCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyAppointCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
