//
//  RentRoomOfficeInfoCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RentRoomOfficeDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentRoomOfficeInfoCell : UITableViewCell

@property (nonatomic, strong) RentRoomOfficeDetailModel *model;

@property (nonatomic, strong) UILabel *transferL;

@property (nonatomic, strong) UILabel *depositL;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) UILabel *rentTypeL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *minPeriodL;

@property (nonatomic, strong) UILabel *maxPeriodL;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) UILabel *inTimeL;

@property (nonatomic, strong) UILabel *seeL;

@property (nonatomic, strong) UILabel *rentFreeL;

@property (nonatomic, strong) UILabel *accommodateL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) UIView *markView;

@property (nonatomic, strong) UILabel *markL;

@end

NS_ASSUME_NONNULL_END
