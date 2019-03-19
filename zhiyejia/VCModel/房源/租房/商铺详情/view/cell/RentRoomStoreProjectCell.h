//
//  RentRoomHouseProjectCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RentRoomHouseDetailModel.h"
#import "RentRoomStoreDetailModel.h"
//#import "RentRoomOfficeDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

//typedef <#returnType#>(^<#name#>)(<#arguments#>);

@interface RentRoomStoreProjectCell : UITableViewCell

@property (nonatomic, strong) RentRoomHouseDetailModel *houseModel;

@property (nonatomic, strong) RentRoomStoreDetailModel *storeModel;

//@property (nonatomic, strong) SecRoomOfficeDetailModel *officeModel;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *buildL;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UIImageView *roomImg;

@end

NS_ASSUME_NONNULL_END
