//
//  NewRoomProjectMapCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewRoomProjectMapCell.h"

#import "NewRoomMapCollCell.h"

@interface NewRoomProjectMapCell()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,BMKMapViewDelegate,BMKPoiSearchDelegate>
{
    
    CLLocationCoordinate2D _leftBottomPoint;
    CLLocationCoordinate2D _rightBottomPoint;//地图矩形的顶点
    NSArray *namearr;
    NSArray *_color;
    NSArray *_namecolor;
    BMKPointAnnotation *_annotation;
    CLLocationCoordinate2D _cllocation;
    NSString *_name;
}

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation NewRoomProjectMapCell

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
    [_mapView setCenterCoordinate:_cllocation animated:YES];
}

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    
    _leftBottomPoint = [_mapView convertPoint:CGPointMake(0,_mapView.frame.size.height) toCoordinateFromView:mapView];  // //西南角（左下角） 屏幕坐标转地理经纬度
    _rightBottomPoint = [_mapView convertPoint:CGPointMake(_mapView.frame.size.width,0) toCoordinateFromView:mapView];  //东北角（右上角）同上
    //开始搜索
}

- (void)beginSearchWithname:(NSString *)name{
    
    _name = name;
    _poisearch = [self poisearch];
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
        
        [_mapView setCenterCoordinate:coor animated:YES];
    });
}
//-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
//        
//        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
//        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
//        if ([annotation.title isEqualToString:_model.project_name]) {
//            newAnnotationView.image = [UIImage imageNamed:@"coordinates"];
//        }
//        else
//        {
//            NSArray *arr= @[@"教育",@"公交站点",@"医院",@"购物",@"餐饮"];
//            if ([_name isEqualToString:arr[0]]) {
//                newAnnotationView.image = [UIImage imageNamed:@"education"];
//            }
//            else if ([_name isEqualToString:arr[1]]) {
//                newAnnotationView.image = [UIImage imageNamed:@"traffic"];
//            }
//            else if ([_name isEqualToString:arr[2]]) {
//                newAnnotationView.image = [UIImage imageNamed:@"hospital"];
//            }
//            else if ([_name isEqualToString:arr[3]]) {
//                newAnnotationView.image = [UIImage imageNamed:@"shopping"];
//            }
//            else
//            {
//                newAnnotationView.image = [UIImage imageNamed:@"caterin"];
//            }
//            
//        }
//        
//        return newAnnotationView;
//    }
//    return nil;
//    
//}



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
    
//    if (_delegate && [_delegate respondsToSelector:@selector(Cell4collectionView:didSelectItemAtIndexPath:)]) {
//
//        [_delegate Cell4collectionView:_POIColl didSelectItemAtIndexPath:indexPath];
//    }else{
//
//        //        NSLog(@"没有代理人");
//    }
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;
    self.contentView.backgroundColor = CLWhiteColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 9 *SIZE, 80 *SIZE, 15 *SIZE)];
    label.textColor = CLTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"周边及配套";
    [self.contentView addSubview:label];
    
//    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 33 *SIZE, SCREEN_Width, 187 *SIZE)];
//    _mapView.delegate = self;
//    _mapView.zoomLevel = 15;
//    _mapView.isSelectedAnnotationViewFront = YES;
//    [self.contentView addSubview:_mapView];
    
//    _annotation = [[BMKPointAnnotation alloc]init];
//    [_mapView addAnnotation:_annotation];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(60 *SIZE, 27 *SIZE);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.minimumInteritemSpacing = 10 *SIZE;
    //    _flowLayout.minimumLineSpacing = 15 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(17 *SIZE, 10 *SIZE, 16 *SIZE, 11 *SIZE);
    
    _POIColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 220 *SIZE, SCREEN_Width, 60 *SIZE) collectionViewLayout:_flowLayout];
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
        make.top.equalTo(self.contentView).offset(33 *SIZE);
        make.right.equalTo(self.contentView).offset(0);
        make.width.equalTo(@(360 *SIZE));
        make.height.equalTo(@(187 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-59 *SIZE);
    }];
    
//    [_POIColl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//    }];
}

@end
