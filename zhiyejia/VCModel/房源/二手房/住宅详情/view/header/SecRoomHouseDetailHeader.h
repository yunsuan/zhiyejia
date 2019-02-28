//
//  SecRoomHouseDetailHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomHouseDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) UIScrollView *imgScroll;

@property (nonatomic, strong) UIView *alphaView;

@property (nonatomic, strong) UICollectionView *imgColl;

@property (nonatomic, strong) NSMutableArray *imgArr;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *attentL;

//@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *priceTL;

@property (nonatomic, strong) UIImageView *statusImg;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *typeTL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *areaTL;

@property (nonatomic, strong) UIView *moreView;

@end

NS_ASSUME_NONNULL_END
