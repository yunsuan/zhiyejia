//
//  SecRoomStoreNeiborCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecRoomStoreDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomStoreNeiborCell : UITableViewCell

@property (nonatomic, strong) SecRoomStoreDetailModel *model;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *leftL;

@property (nonatomic, strong) UIImageView *leftImg;

@property (nonatomic, strong) UILabel *rightL;

@property (nonatomic, strong) UIImageView *centerImg;

@property (nonatomic, strong) UILabel *centerL;

@property (nonatomic, strong) UIImageView *rightImg;

@end

NS_ASSUME_NONNULL_END
