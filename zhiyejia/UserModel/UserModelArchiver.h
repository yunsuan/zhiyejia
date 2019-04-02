//
//  UserModelArchiver.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModelArchiver : NSObject

+ (UserModel *)unarchive; //解码
+ (void)archive; //归档
+ (void)ClearUserInfoModel;

@end

NS_ASSUME_NONNULL_END
