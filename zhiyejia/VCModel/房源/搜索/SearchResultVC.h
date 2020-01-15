//
//  SearchResultVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultVC : BaseViewController

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *typeId;

@property (nonatomic, strong) NSString *param;

@property (nonatomic, assign) BOOL isFirstLoading;

- (instancetype)initWithType:(NSString *)type title:(NSString *)title city:(NSString *)city;

- (void)RequestMethod;

@end

NS_ASSUME_NONNULL_END
