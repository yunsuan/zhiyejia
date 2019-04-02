//
//  UserInfoModel.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/2.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : BaseModel

@property (nonatomic, strong) NSString *absolute_address;

@property (nonatomic, strong) NSString *account;

@property (nonatomic, strong) NSString *birth;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *district;

@property (nonatomic, strong) NSString *head_img;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) NSString *tel;

@end

NS_ASSUME_NONNULL_END
