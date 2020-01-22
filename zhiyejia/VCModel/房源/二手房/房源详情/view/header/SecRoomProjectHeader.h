//
//  SecRoomProjectHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecRoomProjectHeaderMoreBlock)(void);

typedef void(^SecRoomProjectHeaderImgBtnBlock)(NSInteger num,NSArray *imgArr);

typedef void(^SecRoomProjectHeaderTagBlock)(NSInteger btnNum);

@interface SecRoomProjectHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) SecRoomProjectHeaderMoreBlock secRoomProjectHeaderMoreBlock;

@property (nonatomic, copy) SecRoomProjectHeaderImgBtnBlock secRoomProjectHeaderImgBtnBlock;

@property (nonatomic, copy) SecRoomProjectHeaderTagBlock secRoomProjectHeaderTagBlock;

@property (nonatomic, strong) UIScrollView *imgScroll;

@property (nonatomic, strong) UIButton *ImgBtn;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UILabel *saleNumL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UIImageView *addressImg;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIView *btnView;

@property (nonatomic, strong) NSMutableArray *imgArr;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
