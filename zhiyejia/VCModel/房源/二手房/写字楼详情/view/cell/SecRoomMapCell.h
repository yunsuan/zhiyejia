//
//  SecRoomMapCell.h
//  zhiyejia
//
//  Created by xiaoq on 2019/7/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
NS_ASSUME_NONNULL_BEGIN

@interface SecRoomMapCell : UITableViewCell
@property (nonatomic, strong) UICollectionView *POIColl;

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKPoiSearch *poisearch;

- (void)SetLatitude:(NSString *)latitude longitude:(NSString *)longitude project:(NSString *)project;

@end

NS_ASSUME_NONNULL_END
