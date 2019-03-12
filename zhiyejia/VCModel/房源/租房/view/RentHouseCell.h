//
//  RentHouseCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/12.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RentHouseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentHouseCell : UITableViewCell

@property (nonatomic, strong) RentHouseModel *model;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UIView *hideView;

@property (nonatomic, strong) UILabel *hideL;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIImageView *statusImg;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *storeL;

//@property (nonatomic, strong) TagView *tagView;
//
//@property (nonatomic, strong) TagView *tagView2;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
