//
//  SecHouseSaleHouseDemandVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseSaleHouseDemandVCBlock)(void);

@interface SecHouseSaleHouseDemandVC : BaseViewController

- (instancetype)initWithType:(NSString *)type property:(NSString *)property;

@property (nonatomic, copy) SecHouseSaleHouseDemandVCBlock secHouseSaleHouseDemandVCBlock;

@end

NS_ASSUME_NONNULL_END
