//
//  CheckStoreCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckStoreCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UILabel *distanceL;

@property (nonatomic, strong) UIButton *navBtn;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
