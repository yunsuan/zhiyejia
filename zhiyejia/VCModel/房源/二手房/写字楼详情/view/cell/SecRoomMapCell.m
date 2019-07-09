//
//  SecRoomMapCell.m
//  zhiyejia
//
//  Created by xiaoq on 2019/7/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomMapCell.h"
#import "NewRoomMapCollCell.h"

@interface SecRoomMapCell()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,BMKMapViewDelegate,BMKPoiSearchDelegate>
{
    
    CLLocationCoordinate2D _leftBottomPoint;
    CLLocationCoordinate2D _rightBottomPoint;//地图矩形的顶点
    NSArray *namearr;
    NSArray *_color;
    NSArray *_namecolor;
    BMKPointAnnotation *_annotation;
    CLLocationCoordinate2D _cllocation;
    NSString *_name;
    NSString *_projectname;
}

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation SecRoomMapCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        namearr = @[@"教育",@"交通",@"医院",@"购物",@"餐饮"];
        _color = @[COLOR(213, 242, 255, 1),COLOR(234, 242, 237, 1),COLOR(208, 243, 245, 1),COLOR(255, 237, 211, 1),COLOR(255, 185, 158, 1)];
        _namecolor = @[COLOR(63, 176, 237, 1),COLOR(107, 188, 137, 1),COLOR(120, 189, 194, 1),COLOR(232, 143, 14, 1),COLOR(210, 101, 61, 1)];
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)SetLatitude:(NSString *)latitude longitude:(NSString *)longitude project:(NSString *)project{
    
    
    _cllocation = CLLocationCoordinate2DMake([latitude floatValue] , [longitude floatValue]);
    _annotation.coordinate = _cllocation;
    _annotation.title = project;
    _projectname = project;
    [_mapView setCenterCoordinate:_cllocation animated:YES];
}

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    
    _leftBottomPoint = [_mapView convertPoint:CGPointMake(0,_mapView.frame.size.height) toCoordinateFromView:mapView];  // //西南角（左下角） 屏幕坐标转地理经纬度
    _rightBottomPoint = [_mapView convertPoint:CGPointMake(_mapView.frame.size.width,0) toCoordinateFromView:mapView];  //东北角（右上角）同上
    //开始搜索
}

- (void)beginSearchWithname:(NSString *)name{
    
    _name = name;
    //    _poisearch = [self poisearch];
    //初始化BMKPoiSearch实例
    BMKPoiSearch *poiSearch = [[BMKPoiSearch alloc] init];
    //设置POI检索的代理
    poiSearch.delegate = self;
    //初始化请求参数类BMKNearbySearchOption的实例
    BMKPOINearbySearchOption *nearbyOption = [[BMKPOINearbySearchOption alloc]init];
    /**
     检索关键字，必选。
     在周边检索中关键字为数组类型，可以支持多个关键字并集检索，如银行和酒店。每个关键字对应数组一个元素。
     最多支持10个关键字。
     */
    nearbyOption.keywords = @[_name];
    //检索中心点的经纬度，必选
    nearbyOption.location = _cllocation;
    /**
     检索半径，单位是米。
     当半径过大，超过中心点所在城市边界时，会变为城市范围检索，检索范围为中心点所在城市
     */
    nearbyOption.radius = 1000;
    /**
     根据中心点、半径和检索词发起周边检索：异步方法，返回结果在BMKPoiSearchDelegate
     的onGetPoiResult里
     
     nearbyOption 周边搜索的搜索参数类
     成功返回YES，否则返回NO
     */
    BOOL flag = [poiSearch poiSearchNearBy:nearbyOption];
    if(flag) {
        NSLog(@"POI周边检索成功");
    } else {
        NSLog(@"POI周边检索失败");
    }
    //    BMKBoundSearchOption *boundSearchOption = [[BMKBoundSearchOption alloc]init];
    //    boundSearchOption.pageIndex = 0;
    //    boundSearchOption.pageCapacity = 20;
    //    boundSearchOption.keyword = name;
    //    boundSearchOption.leftBottom =_leftBottomPoint;
    //    boundSearchOption.rightTop =_rightBottomPoint;
    //
    //    BOOL flag = [_poisearch poiSearchInbounds:boundSearchOption];
    //    if(flag)
    //    {
    //        NSLog(@"范围内检索发送成功");
    //    }
    //    else
    //    {
    //        NSLog(@"范围内检索发送失败");
    //    }
}


- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPOISearchResult *)poiResult errorCode:(BMKSearchErrorCode)error {
    //BMKSearchErrorCode错误码，BMK_SEARCH_NO_ERROR：检索结果正常返回
    if (error == BMK_SEARCH_NO_ERROR) {
        //实现对检索结果的处理
        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        array = [NSArray arrayWithArray:_mapView.overlays];
        [_mapView removeOverlays:array];
        //在此处理正常结果
        for (int i = 0; i < poiResult.poiInfoList.count; i++)
        {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            [self addAnimatedAnnotationWithName:poi.name withAddress:poi.pt];
        }
        
        //                CLLocationCoordinate2D cllocation = CLLocationCoordinate2DMake([_model.latitude floatValue] , [_model.longitude floatValue]);
        [_mapView setCenterCoordinate:_cllocation animated:YES];
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate = _cllocation;
        annotation.title = _projectname;
        [_mapView addAnnotation:annotation];
        
    }
}
//#pragma mark implement BMKSearchDelegate
//- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
//{
//    if (error == BMK_SEARCH_NO_ERROR) {
//        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//        [_mapView removeAnnotations:array];
//        array = [NSArray arrayWithArray:_mapView.overlays];
//        [_mapView removeOverlays:array];
//        //在此处理正常结果
//        for (int i = 0; i < result.poiInfoList.count; i++)
//        {
//            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
//            [self addAnimatedAnnotationWithName:poi.name withAddress:poi.pt];
//        }
//
//        CLLocationCoordinate2D cllocation = CLLocationCoordinate2DMake([_model.latitude floatValue] , [_model.longitude floatValue]);
//        [_mapView setCenterCoordinate:cllocation animated:YES];
//        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//        annotation.coordinate = cllocation;
//        annotation.title = _model.project_name;
//        [_mapView addAnnotation:annotation];
//
//    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
//        NSLog(@"起始点有歧义");
//    } else {
//        // 各种情况的判断。。。
//    }
//}

// 添加动画Annotation
- (void)addAnimatedAnnotationWithName:(NSString *)name withAddress:(CLLocationCoordinate2D)coor {
    
    BMKPointAnnotation*animatedAnnotation = [[BMKPointAnnotation alloc]init];
    animatedAnnotation.coordinate = coor;
    animatedAnnotation.title = name;
    [_mapView addAnnotation:animatedAnnotation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self->_mapView setCenterCoordinate:coor animated:YES];
    });
}
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        if ([annotation.title isEqualToString:_projectname]) {
            newAnnotationView.image = [UIImage imageNamed:@"coordinates"];
        }
        else
        {
            NSArray *arr= @[@"教育",@"公交站点",@"医院",@"购物",@"餐饮"];
            if ([_name isEqualToString:arr[0]]) {
                newAnnotationView.image = [UIImage imageNamed:@"education"];
            }
            else if ([_name isEqualToString:arr[1]]) {
                newAnnotationView.image = [UIImage imageNamed:@"traffic"];
            }
            else if ([_name isEqualToString:arr[2]]) {
                newAnnotationView.image = [UIImage imageNamed:@"hospital"];
            }
            else if ([_name isEqualToString:arr[3]]) {
                newAnnotationView.image = [UIImage imageNamed:@"shopping"];
            }
            else if ([_name isEqualToString:arr[4]])
            {
                newAnnotationView.image = [UIImage imageNamed:@"caterin"];
            }
            else
            {
                newAnnotationView.image = [UIImage imageNamed:@"coordinates"];
            }
            
        }
        
        return newAnnotationView;
    }
    return nil;
    
}



- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    _leftBottomPoint = [_mapView convertPoint:CGPointMake(0,_mapView.frame.size.height) toCoordinateFromView:mapView];  // //西南角（左下角） 屏幕坐标转地理经纬度
    _rightBottomPoint = [_mapView convertPoint:CGPointMake(_mapView.frame.size.width,0) toCoordinateFromView:mapView];  //东北角（右上角）同上
}

-(BMKPoiSearch *)poisearch
{
    if (!_poisearch) {
        _poisearch =[[BMKPoiSearch alloc]init];
        _poisearch.delegate = self;
    }
    return _poisearch;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NewRoomMapCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewRoomMapCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[NewRoomMapCollCell alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 27 *SIZE)];
    }
    
    cell.titleL.text = namearr[indexPath.row];
    cell.backgroundColor = _color[indexPath.row];
    cell.titleL.textColor = _namecolor[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self beginSearchWithname:namearr[indexPath.row]];
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;
    self.contentView.backgroundColor = CLWhiteColor;

    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 187 *SIZE)];
    _mapView.delegate = self;
    _mapView.zoomLevel = 15;
    _mapView.isSelectedAnnotationViewFront = YES;
    [self.contentView addSubview:_mapView];
    
    _annotation = [[BMKPointAnnotation alloc]init];
    [_mapView addAnnotation:_annotation];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(60 *SIZE, 27 *SIZE);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.minimumInteritemSpacing = 10 *SIZE;
    //    _flowLayout.minimumLineSpacing = 15 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(17 *SIZE, 10 *SIZE, 16 *SIZE, 11 *SIZE);
    
    _POIColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 190 *SIZE, SCREEN_Width, 60 *SIZE) collectionViewLayout:_flowLayout];
    _POIColl.backgroundColor = self.contentView.backgroundColor;
    _POIColl.delegate = self;
    _POIColl.dataSource = self;
    
    [_POIColl registerClass:[NewRoomMapCollCell class] forCellWithReuseIdentifier:@"NewRoomMapCollCell"];
    [self.contentView addSubview:_POIColl];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        //        make.right.equalTo(self.contentView).offset(0);
        make.width.equalTo(@(360 *SIZE));
        make.height.equalTo(@(187 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-59 *SIZE);
    }];
    
    //    [_POIColl mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //    }];
}

@end



