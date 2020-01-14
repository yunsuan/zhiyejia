//
//  SecRoomDealListCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomDealListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) UILabel *agentL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UIView *line;
@end

NS_ASSUME_NONNULL_END
