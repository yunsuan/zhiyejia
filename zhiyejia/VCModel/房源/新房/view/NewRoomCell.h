//
//  NewRoomCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewRoomModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewRoomCell : UITableViewCell

@property (nonatomic, strong) UIImageView *roomImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NewRoomModel *model;

@end

NS_ASSUME_NONNULL_END
