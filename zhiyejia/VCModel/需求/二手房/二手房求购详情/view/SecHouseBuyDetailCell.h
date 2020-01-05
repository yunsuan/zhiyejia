//
//  SecHouseBuyDetailCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecHouseBuyDetailCell : UITableViewCell

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *regionL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) UILabel *useL;

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) UILabel *tagL;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UILabel *otherL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
