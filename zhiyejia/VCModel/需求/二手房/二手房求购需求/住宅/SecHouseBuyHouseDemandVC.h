//
//  SecHouseBuyHouseDemandVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/2/9.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseBuyHouseDemandVCBlock)(void);

@interface SecHouseBuyHouseDemandVC : BaseViewController

- (instancetype)initWithType:(NSString *)type property:(NSString *)property;

@property (nonatomic, copy) SecHouseBuyHouseDemandVCBlock secHouseBuyHouseDemandVCBlock;

@end

NS_ASSUME_NONNULL_END
