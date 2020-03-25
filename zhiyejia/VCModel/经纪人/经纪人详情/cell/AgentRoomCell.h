//
//  AgentRoomCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AgentRoomCellBlock)(NSInteger idx);

@interface AgentRoomCell : UITableViewCell

@property (nonatomic, copy) AgentRoomCellBlock agentRoomCellBlock;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) NSArray *dataArr;

@end

NS_ASSUME_NONNULL_END
