//
//  NewRoomProjectDynamicCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NewRoomProjectDynamicCellBlock)(void);

@interface NewRoomProjectDynamicCell : UITableViewCell

@property (nonatomic, copy) NewRoomProjectDynamicCellBlock newRoomProjectDynamicCellBlock;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *contentL;

@end

NS_ASSUME_NONNULL_END
