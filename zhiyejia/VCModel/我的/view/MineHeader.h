//
//  MineHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MineHeaderView.h"

typedef void(^MineHeaderImgBlock)(void);

typedef void(^MineHeaderNameBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface MineHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) MineHeaderImgBlock mineHeaderImgBlock;

@property (nonatomic, copy) MineHeaderNameBlock mineHeaderNameBlock;

@property (nonatomic, strong) UIImageView *headerImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) MineHeaderView *backView;

@property (nonatomic, strong) UIImageView *rightImg;

@end

NS_ASSUME_NONNULL_END
