//
//  NewRoomProjectAgentCollCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/5.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NewRoomProjectAgentCollCellPhoneBlock)(void);

@interface NewRoomProjectAgentCollCell : UICollectionViewCell

@property (nonatomic, strong) NewRoomProjectAgentCollCellPhoneBlock newRoomProjectAgentCollCellPhoneBlock;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIButton *phoneBtn;

@end

NS_ASSUME_NONNULL_END
