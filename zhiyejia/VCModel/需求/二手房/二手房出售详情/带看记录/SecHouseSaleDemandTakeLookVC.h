//
//  SecHouseSaleDemandTakeLookVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecHouseSaleDemandTakeLookVC : BaseViewController

@property (nonatomic, strong) NSDictionary *takeDic;

- (instancetype)initWithDataArr:(NSArray *)dataArr;

@end

NS_ASSUME_NONNULL_END
