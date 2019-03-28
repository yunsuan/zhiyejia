//
//  SecRoomHouseInfoCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecRoomHouseDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomHouseInfoCell : UITableViewCell

@property (nonatomic, strong) SecRoomHouseDetailModel *model;

//@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) UILabel *inTimeL;

@property (nonatomic, strong) UILabel *proLimitL;

@property (nonatomic, strong) UIView *markView;

@property (nonatomic, strong) UILabel *markL;

@end

NS_ASSUME_NONNULL_END
