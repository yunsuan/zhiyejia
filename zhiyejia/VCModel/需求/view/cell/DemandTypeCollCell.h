//
//  DemandTypeCollCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DemandTypeCollCellBlock)(NSInteger idx);

@interface DemandTypeCollCell : UICollectionViewCell

@property (nonatomic, copy) DemandTypeCollCellBlock demandTypeCollCellBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *addBtn;

@end

NS_ASSUME_NONNULL_END
