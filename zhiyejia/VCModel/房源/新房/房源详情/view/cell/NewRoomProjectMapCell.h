//
//  NewRoomProjectMapCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewRoomProjectMapCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *POIColl;

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKPoiSearch *poisearch;

- (void)SetLatitude:(NSString *)latitude longitude:(NSString *)longitude project:(NSString *)project;

@end

NS_ASSUME_NONNULL_END
