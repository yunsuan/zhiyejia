//
//  NewRoomProjectHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TagCollCell.h"
#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NewRoomProjectHeaderMoreBlock)(void);

typedef void(^NewRoomProjectHeaderImgBtnBlock)(NSInteger num,NSArray *imgArr);

@interface NewRoomProjectHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) NewRoomProjectHeaderMoreBlock newRoomProjectHeaderMoreBlock;

@property (nonatomic, copy) NewRoomProjectHeaderImgBtnBlock newRoomProjectHeaderImgBtnBlock;

@property (nonatomic, strong) UIScrollView *imgScroll;

@property (nonatomic, strong) UIButton *ImgBtn;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

//@property (nonatomic, strong) UICollectionViewFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *developerL;

@property (nonatomic, strong) UIImageView *addressImg;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableArray *imgArr;

@end

NS_ASSUME_NONNULL_END
