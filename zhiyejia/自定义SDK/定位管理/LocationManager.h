//
//  LocationManager.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/6.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject

+(LocationManager *)Manager;
+(NSString *)GetCityName;
+(NSString *)GetCityCode;
-(void)startLocationSuccess:(void(^)(NSString *cityname,NSString *citycode)) success
                      Faild:(void(^)(void)) faild;
-(void)stopLocation;
   
@end

NS_ASSUME_NONNULL_END
