//
//  NewRoomDiscountCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NewRoomDiscountCellBlock)(void);

@interface NewRoomDiscountCell : UITableViewCell

@property (nonatomic, copy) NewRoomDiscountCellBlock newRoomDiscountCellBlock;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIButton *moreBtn;

@end

NS_ASSUME_NONNULL_END
