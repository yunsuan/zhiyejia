//
//  NewRoomProjectHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TagCollCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NewRoomProjectHeaderBlock)(void);

@interface NewRoomProjectHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) NewRoomProjectHeaderBlock newRoomProjectHeaderBlock;

@property (nonatomic, strong) UIScrollView *imgScroll;

@property (nonatomic, strong) UIButton *ImgBtn;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UICollectionViewFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *tagFlowLayout;

@property (nonatomic, strong) UICollectionView *tagColl;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *developerL;

@property (nonatomic, strong) UIImageView *addressImg;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) NSMutableArray *imgArr;

@property (nonatomic, strong) UIButton *moreBtn;

@end

NS_ASSUME_NONNULL_END
