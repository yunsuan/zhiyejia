//
//  NewRoomProjectAgentCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/5.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NewRoomProjectAgentCellBlock)(NSInteger idx);

@interface NewRoomProjectAgentCell : UITableViewCell

@property (nonatomic, copy) NewRoomProjectAgentCellBlock newRoomProjectAgentCellBlock;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

NS_ASSUME_NONNULL_END
