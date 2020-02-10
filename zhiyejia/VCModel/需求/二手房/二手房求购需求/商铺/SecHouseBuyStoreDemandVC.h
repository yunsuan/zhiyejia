//
//  SecHouseBuyStoreDemandVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/2/9.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseBuyStoreDemandVCBlock)(void);

@interface SecHouseBuyStoreDemandVC : BaseViewController

@property (nonatomic, copy) SecHouseBuyStoreDemandVCBlock secHouseBuyStoreDemandVCBlock;

@end

NS_ASSUME_NONNULL_END
