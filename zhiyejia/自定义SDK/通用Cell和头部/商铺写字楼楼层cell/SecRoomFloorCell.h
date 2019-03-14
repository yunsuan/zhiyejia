//
//  SecRoomFloorCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecRoomStoreDetailModel.h"
#import "SecRoomOfficeDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomFloorCell : UITableViewCell

@property (nonatomic, strong) SecRoomStoreDetailModel *model;

@property (nonatomic, strong) SecRoomOfficeDetailModel *officeModel;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *highL;

@property (nonatomic, strong) UILabel *highTL;

@property (nonatomic, strong) UILabel *widthL;

@property (nonatomic, strong) UILabel *widthTL;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) UILabel *yearTL;

@end

NS_ASSUME_NONNULL_END
