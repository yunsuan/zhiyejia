//
//  SecHouseBuyOfficeDemandVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/2/11.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseBuyOfficeDemandVCBlock)(void);

@interface SecHouseBuyOfficeDemandVC : BaseViewController

@property (nonatomic, copy) SecHouseBuyOfficeDemandVCBlock secHouseBuyOfficeDemandVCBlock;

@end

NS_ASSUME_NONNULL_END
