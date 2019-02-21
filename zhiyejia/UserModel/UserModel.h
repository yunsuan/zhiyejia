//
//  UserModel.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) NSMutableArray *tagAllArr;

@property (nonatomic, strong) NSMutableArray *tagSelectArr;

+ (UserModel *)defaultModel;

@end

NS_ASSUME_NONNULL_END
