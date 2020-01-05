//
//  SecHouseBuyDemandDetailRecommendDetailCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecHouseBuyDemandDetailRecommendDetailCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *unitL;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *timeBtn;

@property (nonatomic, strong) UIButton *appointBtn;

@property (nonatomic, strong) UIButton *noMoreBtn;

@property (nonatomic, strong) UILabel *recommendL;

@property (nonatomic, strong) UILabel *seeNumL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
