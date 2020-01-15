//
//  StoreDemandVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^StoreDemandVCBlock)(void);

@interface StoreDemandVC : BaseViewController

@property (nonatomic, copy) StoreDemandVCBlock storeDemandVCBlock;

@end

NS_ASSUME_NONNULL_END
