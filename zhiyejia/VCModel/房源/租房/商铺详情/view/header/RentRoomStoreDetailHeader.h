//
//  RentRoomStoreDetailHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RentRoomStoreDetailModel.h"
#import "RentRoomHouseDetailModel.h"
#import "RentRoomOfficeDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentRoomStoreDetailHeaderImgBlock)(NSInteger num,NSArray *imgArr);

@interface RentRoomStoreDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) RentRoomHouseDetailModel *model;

@property (nonatomic, strong) RentRoomStoreDetailModel *storeModel;

@property (nonatomic, strong) RentRoomOfficeDetailModel *officeModel;

@property (nonatomic, strong) NSMutableArray *imgArr;

@property (nonatomic, strong) NSMutableDictionary *focusDic;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, copy) RentRoomStoreDetailHeaderImgBlock rentRoomStoreDetailHeaderImgBlock;

@property (nonatomic, strong) UIScrollView *imgScroll;

@property (nonatomic, strong) UIView *alphaView;

@property (nonatomic, strong) UICollectionView *imgColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *attentL;

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
