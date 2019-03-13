//
//  SecRoomHouseDynamicCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomHouseDynamicCell : UITableViewCell

@property (nonatomic, strong) UILabel *daysL;

@property (nonatomic, strong) UILabel *daysLabel;

@property (nonatomic, strong) UILabel *allL;

@property (nonatomic, strong) UILabel *allLabel;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *intentLabel;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
