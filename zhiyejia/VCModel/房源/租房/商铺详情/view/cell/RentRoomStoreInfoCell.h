//
//  RentRoomHouseInfoCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RentRoomStoreDetailModel.h"
//#import "RentRoomHouseDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentRoomStoreInfoCell : UITableViewCell

@property (nonatomic, strong) RentRoomStoreDetailModel *storeModel;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

//@property (nonatomic, strong) RentRoomHouseDetailModel *model;

@property (nonatomic, strong) UILabel *transferL;

@property (nonatomic, strong) UILabel *depositL;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) UILabel *rentTypeL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *minPeriodL;

@property (nonatomic, strong) UILabel *maxPeriodL;

@property (nonatomic, strong) UILabel *inTimeL;

@property (nonatomic, strong) UILabel *seeL;

@property (nonatomic, strong) UILabel *rentFreeL;

@property (nonatomic, strong) UILabel *commercailL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) UIView *markView;

@property (nonatomic, strong) UILabel *markL;

@end

NS_ASSUME_NONNULL_END
