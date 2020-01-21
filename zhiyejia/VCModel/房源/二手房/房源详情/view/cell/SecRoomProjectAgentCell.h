//
//  SecRoomProjectAgentCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/12.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecRoomProjectAgentCellWorkBlock)(void);

typedef void(^SecRoomProjectAgentCellPhoneBlock)(void);

@interface SecRoomProjectAgentCell : UITableViewCell

@property (nonatomic, copy) SecRoomProjectAgentCellWorkBlock secRoomProjectAgentCellWorkBlock;

@property (nonatomic, copy) SecRoomProjectAgentCellPhoneBlock secRoomProjectAgentCellPhoneBlock;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *professionL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *historyL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
