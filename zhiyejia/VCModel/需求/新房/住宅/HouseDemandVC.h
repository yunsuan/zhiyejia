//
//  HouseDemandVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HouseDemandVCBlock)(void);

@interface HouseDemandVC : BaseViewController

- (instancetype)initWithType:(NSString *)type property:(NSString *)property;

@property (nonatomic, copy) HouseDemandVCBlock houseDemandVCBlock;

@end

NS_ASSUME_NONNULL_END
