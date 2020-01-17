//
//  SecHouseSaleDemandWaitDetailVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseSaleDemandWaitDetailVCBlock)(void);

@interface SecHouseSaleDemandWaitDetailVC : BaseViewController

@property (nonatomic, copy) SecHouseSaleDemandWaitDetailVCBlock secHouseSaleDemandWaitDetailVCBlock;

@property (nonatomic, copy) NSString *status;

- (instancetype)initWithRecomendId:(NSString *)recommend_id;

@end

NS_ASSUME_NONNULL_END
