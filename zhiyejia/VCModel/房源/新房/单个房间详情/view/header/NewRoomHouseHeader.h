//
//  NewRoomHouseHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NewRoomHouseHeaderImgBtnBlock)(NSInteger num,NSArray *imgArr);

@interface NewRoomHouseHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) NewRoomHouseHeaderImgBtnBlock newRoomHouseHeaderImgBtnBlock;

@property (nonatomic, strong) UIImageView *bigImg;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UICollectionView *imgColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *imgArr;

@end

NS_ASSUME_NONNULL_END
