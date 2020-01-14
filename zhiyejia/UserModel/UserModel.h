//
//  UserModel.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *agent_id;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *passWord;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *token;

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

@property (nonatomic, strong) NSMutableArray *cityArr;

@property (nonatomic, strong) NSMutableDictionary *tagDic;

@property (nonatomic, strong) NSMutableArray *tagAllArr;

@property (nonatomic, strong) NSMutableArray *tagSelectArr;

+ (UserModel *)defaultModel;

@end

NS_ASSUME_NONNULL_END
