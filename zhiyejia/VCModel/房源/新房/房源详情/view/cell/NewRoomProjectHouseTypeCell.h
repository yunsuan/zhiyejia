//
//  NewRoomProjectHouseTypeCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^collCellBlock)(NSInteger index);

@interface NewRoomProjectHouseTypeCell : UITableViewCell

@property (nonatomic, copy) collCellBlock collCellBlock;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) UICollectionView *cellColl;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

NS_ASSUME_NONNULL_END
