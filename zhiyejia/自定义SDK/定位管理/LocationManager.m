//
//  LocationManager.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/6.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LocationManager.h"

#import <BMKLocationkit/BMKLocationComponent.h>

@interface LocationManager ()<BMKLocationManagerDelegate>
{
    
    BMKLocationManager *_locationManager;
    void (^_locationSuccess)(NSString *cityname,NSString *citycode);
    void (^_locationFaild)(void);
}
@end

@implementation LocationManager

+ (LocationManager *)Manager{
    static LocationManager *manager;
    @synchronized(self){
        if (!manager) {
            manager = [[LocationManager alloc]init];
        }
    }
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //初始化实例
        _locationManager = [[BMKLocationManager alloc] init];
        //设置delegate
        _locationManager.delegate = self;
        //设置返回位置的坐标系类型
        _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        //设置距离过滤参数
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        //设置预期精度参数
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置应用位置类型
        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        //设置是否自动停止位置更新
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        //设置是否允许后台定位
        //_locationManager.allowsBackgroundLocationUpdates = YES;
        //设置位置获取超时时间
        _locationManager.locationTimeout = 10;
        //设置获取地址信息超时时间
        _locationManager.reGeocodeTimeout = 10;
    }
    return self;
}

- (void)startLocationSuccess:(void (^)(NSString * _Nonnull, NSString * _Nonnull))success Faild:(void (^)(void))faild{
    
    _locationSuccess = success;
    _locationFaild = faild;
    if (_locationManager != nil) {
        
        [self StartLocation];
    }
}

- (void)StartLocation{
    
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
       
        NSLog(@"%@,,,,,,,,,,%@",location,error);
        if (error) {
            
            if (self->_locationFaild) {
                self->_locationFaild();
            }
        }else{
            
            NSString *cityname = location.rgcData.city;
            NSInteger cityInteger = [location.rgcData.adCode integerValue] /100*100;
            NSString *citycode = [NSString stringWithFormat:@"%ld",cityInteger];
            NSUserDefaults *location = [NSUserDefaults standardUserDefaults];
            [location setObject:cityname forKey:@"cityName"];
            [location setObject:citycode forKey:@"cityCode"];
            
            if (self->_locationSuccess) {
                
                self->_locationSuccess(cityname,citycode);
            }
        }
    }];
}

- (void)StartAllLocation{
    
    [_locationManager setLocatingWithReGeocode:YES];
    [_locationManager startUpdatingLocation];
}

- (void)StopLocation{
    
    [_locationManager stopUpdatingLocation];
}

- (void)BMKLocationManager:(BMKLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"%@——————————%@",manager,error);
    
}

- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error{
    
    
    NSLog(@"%@——————————%@——————————%@",manager,location,error);
    if (error) {
        
        if (_locationFaild) {
            _locationFaild();
        }
    }
}

- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateNetworkState:(BMKLocationNetworkState)state orError:(NSError *)error{
    
    NSLog(@"%@——————————%@",manager,error);
    if (error) {
        
        if (_locationFaild) {
            _locationFaild();
        }
    }
}

- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateHeading:(CLHeading *)heading{
    
    NSLog(@"%@——————————%@",manager,heading);
}

+ (NSString *)GetCityName{
    
    NSString *cityname = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
    if (!cityname) {
        
        cityname = @"成都市";
    }
    return cityname;
}

+ (NSString *)GetCityCode{
    
    NSString *citycode = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityCode"];
    if (!citycode) {
        
        citycode = @"510100";
    }
    return citycode;
}
@end
