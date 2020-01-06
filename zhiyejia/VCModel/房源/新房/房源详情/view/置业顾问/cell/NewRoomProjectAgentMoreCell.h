//
//  NewRoomProjectAgentMoreCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/5.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NewRoomProjectAgentMoreCellPraiseBlock)(void);

typedef void(^NewRoomProjectAgentMoreCellPhoneBlock)(void);

@interface NewRoomProjectAgentMoreCell : UITableViewCell

@property (nonatomic, copy) NewRoomProjectAgentMoreCellPraiseBlock newRoomProjectAgentMoreCellPraiseBlock;

@property (nonatomic, copy) NewRoomProjectAgentMoreCellPhoneBlock newRoomProjectAgentMoreCellPhoneBlock;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UIImageView *goldImg;

@property (nonatomic, strong) UILabel *allL;

@property (nonatomic, strong) UILabel *praiseL;

@property (nonatomic, strong) UILabel *activityL;

@property (nonatomic, strong) UIButton *praiseBtn;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;
@end

NS_ASSUME_NONNULL_END
