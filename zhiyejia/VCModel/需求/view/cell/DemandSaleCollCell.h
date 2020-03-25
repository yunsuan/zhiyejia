//
//  DemandSaleCollCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DemandSaleCollCellBlock)(void);

@interface DemandSaleCollCell : UICollectionViewCell

@property (nonatomic, copy) DemandSaleCollCellBlock demandSaleCollCellBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *roomImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *houseNumL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
