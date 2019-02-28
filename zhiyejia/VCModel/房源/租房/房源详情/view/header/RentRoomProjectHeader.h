//
//  RentRoomProjectHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentRoomProjectHeaderBlock)(void);

@interface RentRoomProjectHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) RentRoomProjectHeaderBlock rentRoomProjectHeaderBlock;

@property (nonatomic, strong) UIScrollView *imgScroll;

@property (nonatomic, strong) UIButton *ImgBtn;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UILabel *saleNumL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UICollectionViewFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UIImageView *addressImg;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) NSMutableArray *imgArr;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIView *btnView;

@end

NS_ASSUME_NONNULL_END
