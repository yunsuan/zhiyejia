//
//  RentRoomCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/6.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RentProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentRoomCell : UITableViewCell

@property (nonatomic, strong) RentProjectModel *rentProjectModel;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *averageL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *onSaleL;

@property (nonatomic, strong) UILabel *attionL;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
