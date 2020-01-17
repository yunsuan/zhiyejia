//
//  SecHouseBuyDemandDetailHouseCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecHouseBuyDemandDetailHouseCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIImageView *priceImg;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *refencePriceL;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *mySeeL;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
