//
//  SecRoomOfficeInfoCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomOfficeInfoCell : UITableViewCell

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) UILabel *rentTimeL;

@property (nonatomic, strong) UILabel *rentPriceL;

@property (nonatomic, strong) UILabel *referRentPriceL;

@property (nonatomic, strong) UIView *markView;

@property (nonatomic, strong) UILabel *markL;

@end

NS_ASSUME_NONNULL_END
