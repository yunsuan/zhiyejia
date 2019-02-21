//
//  BaseRequest.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <AFNetworkReachabilityManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseRequest : NSObject

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure;

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure;

+ (void)Updateimg:(NSString *)url parameters:(NSDictionary *)parameters  constructionBody:(void (^)(id <AFMultipartFormData> formData))blocks success:(void (^)(id resposeObject))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
