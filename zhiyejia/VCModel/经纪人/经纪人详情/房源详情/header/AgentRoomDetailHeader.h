//
//  AgentRoomDetailHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AgentRoomDetailHeaderImgBtnBlock)(NSInteger num,NSArray *imgArr);

@interface AgentRoomDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) AgentRoomDetailHeaderImgBtnBlock agentRoomDetailHeaderImgBtnBlock;

@property (nonatomic, strong) UIImageView *bigImg;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UICollectionView *imgColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *imgArr;

@end

NS_ASSUME_NONNULL_END
