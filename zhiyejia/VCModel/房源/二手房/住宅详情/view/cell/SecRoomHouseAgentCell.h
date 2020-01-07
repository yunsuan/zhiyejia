//
//  SecRoomHouseAgentCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/6.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecRoomHouseAgentCellWorkBlock)(void);

typedef void(^SecRoomHouseAgentCellPhoneBlock)(void);

@interface SecRoomHouseAgentCell : UITableViewCell

@property (nonatomic, copy) SecRoomHouseAgentCellWorkBlock secRoomHouseAgentCellWorkBlock;

@property (nonatomic, copy) SecRoomHouseAgentCellPhoneBlock secRoomHouseAgentCellPhoneBlock;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *workImg;

@property (nonatomic, strong) UILabel *scoreL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
