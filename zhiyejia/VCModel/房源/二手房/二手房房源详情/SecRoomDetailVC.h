//
//  SecRoomHouseDetailVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/17.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomDetailVC : BaseViewController

@property (nonatomic, assign) NSInteger type;

- (instancetype)initWithHouseId:(NSString *)houseId city:(NSString *)city;

@end

NS_ASSUME_NONNULL_END
