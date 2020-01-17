//
//  SecHouseSaleDemandDoingDetailVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/16.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseSaleDemandDoingDetailVCBlock)(void);

@interface SecHouseSaleDemandDoingDetailVC : BaseViewController

@property (nonatomic, copy) SecHouseSaleDemandDoingDetailVCBlock secHouseSaleDemandDoingDetailVCBlock;

@property (nonatomic, copy) NSString *status;

- (instancetype)initWithRecomendId:(NSString *)recommend_id;

@end

NS_ASSUME_NONNULL_END
