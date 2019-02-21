//
//  RoomChildVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoomChildVC : BaseViewController

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *typeId;

@property (nonatomic, strong) NSString *param;

@property (nonatomic, assign) BOOL isFirstLoading;

- (instancetype)initWithType:(NSInteger )type;

- (void)RequestMethod;

@end

NS_ASSUME_NONNULL_END
