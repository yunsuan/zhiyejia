//
//  SecRoomStoreEquipCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomStoreEquipCell : UITableViewCell

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

NS_ASSUME_NONNULL_END
