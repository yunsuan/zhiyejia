//
//  MyMessageCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyMessageCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIView *lineView;
@end

NS_ASSUME_NONNULL_END
