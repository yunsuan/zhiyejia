//
//  NewRoomProjectResidentCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/5.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NewRoomProjectResidentCellPhoneBlock)(void);

@interface NewRoomProjectResidentCell : UITableViewCell

@property (nonatomic, copy) NewRoomProjectResidentCellPhoneBlock newRoomProjectResidentCellPhoneBlock;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
