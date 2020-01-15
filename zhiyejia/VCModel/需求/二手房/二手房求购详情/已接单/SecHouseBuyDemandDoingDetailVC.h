//
//  SecHouseBuyDemandDoingDetailVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseBuyDemandDoingDetailVCBlock)(void);

@interface SecHouseBuyDemandDoingDetailVC : BaseViewController

@property (nonatomic, copy) SecHouseBuyDemandDoingDetailVCBlock secHouseBuyDemandDoingDetailVCBlock;

- (instancetype)initWithRecomendId:(NSString *)recommend_id;

@end

NS_ASSUME_NONNULL_END
