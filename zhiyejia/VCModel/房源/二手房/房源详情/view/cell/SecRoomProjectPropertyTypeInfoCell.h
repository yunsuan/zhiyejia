//
//  SecRoomProjectPropertyTypeInfoCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomProjectPropertyTypeInfoCell : UITableViewCell

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIImageView *houseImg;

@property (nonatomic, strong) UIImageView *storeImg;

@property (nonatomic, strong) UIImageView *buildImg;

@property (nonatomic, strong) UILabel *houseL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) UILabel *buildL;

@property (nonatomic, strong) UILabel *houseDetailL;

@property (nonatomic, strong) UILabel *storeDetailL;

@property (nonatomic, strong) UILabel *buildDetailL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *rentDic;

@end

NS_ASSUME_NONNULL_END
