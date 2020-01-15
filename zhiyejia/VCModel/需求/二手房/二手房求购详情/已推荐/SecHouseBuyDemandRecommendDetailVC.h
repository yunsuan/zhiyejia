//
//  SecHouseBuyDemandRecommendDetailVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseBuyDemandRecommendDetailVCBlock)(void);

@interface SecHouseBuyDemandRecommendDetailVC : BaseViewController

@property (nonatomic, copy) SecHouseBuyDemandRecommendDetailVCBlock secHouseBuyDemandRecommendDetailVCBlock;

- (instancetype)initWithRecomendId:(NSString *)recommend_id;

@end

NS_ASSUME_NONNULL_END
