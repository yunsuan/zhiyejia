//
//  SecRoomHouseProjectCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecRoomHouseDetailModel.h"
#import "SecRoomStoreDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomHouseProjectCell : UITableViewCell

@property (nonatomic, strong) SecRoomHouseDetailModel *houseModel;

@property (nonatomic, strong) SecRoomStoreDetailModel *storeModel;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *buildL;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UIImageView *roomImg;

@end

NS_ASSUME_NONNULL_END
