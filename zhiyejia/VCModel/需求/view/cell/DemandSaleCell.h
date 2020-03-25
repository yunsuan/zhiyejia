//
//  DemandSaleCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DemandSaleCellBlock)(NSInteger idx);

@interface DemandSaleCell : UITableViewCell

@property (nonatomic, copy) DemandSaleCellBlock demandSaleCellBlock;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) NSArray *dataArr;

@end

NS_ASSUME_NONNULL_END
