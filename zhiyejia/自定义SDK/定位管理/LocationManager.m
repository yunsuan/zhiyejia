//
//  LocationManager.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/6.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LocationManager.h"

#import<BMKLocationKit/BMKLocationComponent.h>
#import<BaiduMapAPI_Search/BMKGeocodeSearch.h>

@interface LocationManager ()<BMKLocationManagerDelegate,BMKGeoCodeSearchDelegate>
{
    BOOL _isLocation;
    BMKLocationManager *_locService;  //定位
    BMKGeoCodeSearch *_geocodesearch; //地理编码主类，用来查询、返回结果信息
    void (^_locationSuccess)(NSString *cityname,NSString *citycode);
    void (^_locationFaild)(void);
}

@end

@implementation LocationManager

+(LocationManager *)Manager
{
    static LocationManager *manager;
    @synchronized(self){
        if (!manager) {
            manager = [[LocationManager alloc]init];
        }
    }
    return manager;
}

-(void)startLocationSuccess:(void (^)(NSString *, NSString *))success Faild:(void (^)(void))faild
{
    _locationSuccess = success;
    _locationFaild = faild;
    if (_locService != nil) {
        [_locService startUpdatingLocation];
    }
}

-(void)stopLocation
{
    if (_locService != nil) {
        [_locService stopUpdatingLocation];
    }
}

- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager doRequestAlwaysAuthorization:(CLLocationManager * _Nonnull)locationManager
{
    
    [locationManager requestAlwaysAuthorization];
}

//定位成功

- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error{
    
    [_locService stopUpdatingLocation];
    BMKReverseGeoCodeSearchOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeSearchOption alloc] init];
    reverseGeocodeSearchOption.location = location.location.coordinate;
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",location.location.coordinate.latitude] forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",location.location.coordinate.longitude] forKey:@"longitude"];
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag){
        
        //        NSLog(@"反geo检索发送成功");
        
        
    }else{
        
        //        NSLog(@"反geo检索发送失败");
        
    }
}

- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateHeading:(CLHeading *)heading{
    
    NSLog(@"%@",heading);
}

//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
//{
////    [_locService stopUserLocationService];
////    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
////    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
//
////    [JANALYTICSService setLocation:userLocation.location];
//    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
//
//    if(flag){
//
//        //        NSLog(@"反geo检索发送成功");
//
//
//    }else{
//
//        //        NSLog(@"反geo检索发送失败");
//
//    }
//
//}

#pragma mark -------------地理反编码的delegate---------------

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error{
    
    if (error != BMK_SEARCH_NO_ERROR) {
        if (_locationFaild) {
            _locationFaild();
        }
    }else
    {
        NSString *cityname = result.addressDetail.city;
        NSInteger cityInteger = [result.addressDetail.adCode integerValue] /100*100;
        NSString *citycode = [NSString stringWithFormat:@"%ld",cityInteger];
        NSUserDefaults *location = [NSUserDefaults standardUserDefaults];
        [location setObject:cityname forKey:@"cityName"];
        [location setObject:citycode forKey:@"cityCode"];
        if (_locationSuccess) {
            _locationSuccess(cityname,citycode);
        }
        
    }
}

//-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
//
//{
//    if (error != BMK_SEARCH_NO_ERROR) {
//        if (_locationFaild) {
//            _locationFaild();
//        }
//    }else
//    {
//        NSString *cityname = result.addressDetail.city;
//        NSInteger cityInteger = [result.addressDetail.adCode integerValue] /100*100;
//        NSString *citycode = [NSString stringWithFormat:@"%ld",cityInteger];
//        NSUserDefaults *location = [NSUserDefaults standardUserDefaults];
//        [location setObject:cityname forKey:@"cityName"];
//        [location setObject:citycode forKey:@"cityCode"];
//        if (_locationSuccess) {
//            _locationSuccess(cityname,citycode);
//        }
//
//    }
//}

//定位失败

- (void)didFailToLocateUserWithError:(NSError *)error{
    if (_locationFaild) {
        _locationFaild();
    }
}


-(instancetype)init{
    self = [super init];
    if (self) {
        _isLocation = NO;
        _locService = [[BMKLocationManager alloc]init];
        _locService.delegate = self;
        _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locService.distanceFilter = 100.f;
        _geocodesearch =[[BMKGeoCodeSearch alloc]init];
        _geocodesearch.delegate = self;
    }
    return self;
}



+(NSString *)GetCityName
{
    NSString *cityname = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
    if (!cityname) {
        cityname = @"成都市";
    }
    
    return cityname;
}

+(NSString *)GetCityCode
{
    NSString *citycode = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityCode"];
    if (!citycode) {
        citycode = @"510100";
    }
    
    return citycode;
}
@end
