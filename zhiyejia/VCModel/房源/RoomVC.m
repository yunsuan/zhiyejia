//
//  RoomVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//


#import "RoomVC.h"
//项目
#import "NewRoomProjectDetailVC.h"
#import "SecRoomProjectDetailVC.h"
#import "RentRoomProjectDetailVC.h"
//二手房源
#import "SecRoomStoreDetailVC.h"
#import "SecRoomOfficeDetailVC.h"
#import "SecRoomHouseDetailVC.h"
//租房房源
#import "RentRoomHouseDetailVC.h"

#import "RoomChildVC.h"
#import "CityVC.h"

#import "HNChannelView.h"

@interface RoomVC ()<WMPageControllerDataSource,WMPageControllerDelegate>
{
    
    NSMutableArray *_searchArr;
    NSString *_city;
    NSString *_cityName;
    NSMutableArray *_titlearr;
//    BMKLocationManager *_locationManager;
}
@property (nonatomic , strong) UIView *headerView;

@property (nonatomic, strong) UIButton *cityBtn;

@property (nonatomic, strong) UIView *searchBar;

@property (nonatomic, strong) UIButton *moreBtn;

@end

@implementation RoomVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionGoto:) name:@"goto" object:nil];
    
    _titlearr = [UserModel defaultModel].tagSelectArr;

    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {

        [self StartLocation];
    }else{
        [_cityBtn setTitle:@"成都市" forState:UIControlStateNormal];
        _city = [NSString stringWithFormat:@"510100"];
        _cityName = @"成都市";
        [self alertControllerWithNsstring:@"打开[定位服务权限]来允许[云渠道]确定您的位置" And:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" WithCancelBlack:^{


        } WithDefaultBlack:^{

            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
    }
}

- (void)StartLocation{
    
    LocationManager *manager =  [LocationManager Manager];
    [manager startLocationSuccess:^(NSString * _Nonnull cityname, NSString * _Nonnull citycode) {
        
        [self->_cityBtn setTitle:cityname forState:UIControlStateNormal];
        self->_city = citycode;
        self->_cityName = cityname;
        [self pageController:self willEnterViewController:self.childViewControllers[0] withInfo:@{}];
    } Faild:^{
        
        [self alertControllerWithNsstring:@"定位失败" And:@"是否要重新定位" WithCancelBlack:^{
            
        } WithDefaultBlack:^{
            
            [self StartLocation];
        }];
    }];
}

#pragma mark -- Method

- (void)ActionGoto:(NSNotification *)noti{
    
    [self.navigationController.tabBarController setSelectedIndex:1];
}

- (void)ActionSearchBtn:(UIButton *)btn{
    
//    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:_searchArr searchBarPlaceholder:@"请输入楼盘名或地址" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
//        // 开始搜索执行以下代码
//        // 如：跳转到指定控制器
//        if (![self isEmpty:searchText]) {
//
//            RoomChildVC *vc = self.childViewControllers[0];
//            if ([vc.status containsString:@"新房"]) {
//
//                HouseSearchVC *nextVC = [[HouseSearchVC alloc] initWithTitle:searchText city:_city];
//                [searchViewController.navigationController pushViewController:nextVC animated:YES];
//            }else if ([vc.status containsString:@"推荐"] || [vc.status containsString:@"关注"]){
//
//                HouseSearchVC *nextVC = [[HouseSearchVC alloc] initWithTitle:searchText city:_city];
//                [searchViewController.navigationController pushViewController:nextVC animated:YES];
//            }else if ([vc.status containsString:@"小区"]){
//
//                SecProhectSearchVC *nextVC = [[SecProhectSearchVC alloc] initWithTitle:searchText city:_city];
//                //                nextVC.type = self
//                [searchViewController.navigationController pushViewController:nextVC animated:YES];
//            }else{
//
//                SecHouseSearchVC *nextVC = [[SecHouseSearchVC alloc] initWithTitle:searchText city:_city];
//                [searchViewController.navigationController pushViewController:nextVC animated:YES];
//            }
//
//        }
//    }];
//    // 3. 设置风格
//    searchViewController.searchBar.returnKeyType = UIReturnKeySearch;
//    searchViewController.hotSearchStyle = 3; // 热门搜索风格根据选择
//    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为
//    // 4. 设置代理
//    searchViewController.delegate = self;
//    // 5. 跳转到搜索控制器
//    //    [self.navigationController pushViewController:searchViewController animated:YES];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
//    [self.navigationController presentViewController:nav  animated:NO completion:nil];
}

- (void)ActionCityBtn:(UIButton *)btn{
    
    SS(strongSelf);
    CityVC *nextVC = [[CityVC alloc] initWithLabel:_cityName];
    nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {

        [strongSelf->_cityBtn setTitle:city forState:UIControlStateNormal];
        strongSelf->_city = [NSString stringWithFormat:@"%@",code];

        [self pageController:self willEnterViewController:self.childViewControllers[0] withInfo:@{}];
    };
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    HNChannelView *view = [[HNChannelView alloc]initWithFrame:CGRectMake(0, SCREEN_Height, SCREEN_Width, SCREEN_Height -STATUS_BAR_HEIGHT)];
    
    view.clickblook = ^(int selctnum) {
        self->
        _titlearr = [UserModel defaultModel].tagSelectArr;
        self.selectIndex = selctnum;
        [self reloadData];
    };
    
    view.hideblook = ^{
        self->
        _titlearr = [UserModel defaultModel].tagSelectArr;
        [self reloadData];
        [self forceLayoutSubviews];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view show];
}

- (void)initUI{
    
    self.delegate = self;
    self.dataSource = self;
    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 10;
    self.titleColorSelected = [UIColor colorWithRed:27.0/255.0 green:155.0/255.0 blue:255.0/255.0 alpha:1];
    self.menuView.backgroundColor   = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0];

    [self reloadData];
    
    
    self.navBackgroundView.hidden = YES;
    
    _headerView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0,360 *SIZE , 46*SIZE + STATUS_BAR_HEIGHT)];
    _headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headerView];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cityBtn.frame = CGRectMake(0, 19 *SIZE + STATUS_BAR_HEIGHT, 50 *SIZE, 21 *SIZE);
    _cityBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [_cityBtn addTarget:self action:@selector(ActionCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cityBtn setTitleColor:CL86Color forState:UIControlStateNormal];
    [_cityBtn setTitle:@"定位中" forState:UIControlStateNormal];
    [self.headerView addSubview:_cityBtn];
    
    _searchBar = [[UIView alloc] initWithFrame:CGRectMake(58 *SIZE, 13 *SIZE + STATUS_BAR_HEIGHT, 291 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = CLLineColor;
    [self.headerView addSubview:_searchBar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 11 *SIZE, 100 *SIZE, 12 *SIZE)];
    label.textColor = COLOR(147, 147, 147, 1);
    label.text = @"小区/楼盘/商铺";
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    [_searchBar addSubview:label];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(267 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    rightImg.image = [UIImage imageNamed:@"search_2"];
    [_searchBar addSubview:rightImg];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = _searchBar.bounds;
    [searchBtn addTarget:self action:@selector(ActionSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:searchBtn];
    
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.backgroundColor = COLOR(255, 255, 255, 0.9);
    _moreBtn.frame = CGRectMake(320 *SIZE, NAVIGATION_BAR_HEIGHT+20*SIZE, 40 *SIZE, 40 *SIZE);
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setImage:[UIImage imageNamed:@"add_50"] forState:UIControlStateNormal];
    [self.view addSubview:_moreBtn];
    
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    if (_titlearr.count == 0) {
       
        return 0;
    }else{
        
        return _titlearr.count;
    }
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    
    if ([viewController isKindOfClass:[RoomChildVC class]]) {
        NSLog(@"%@",viewController);
        if ([((RoomChildVC *)viewController).city isEqualToString:_city]) {


        }else{

            ((RoomChildVC *)viewController).city = _city;

            [(RoomChildVC *) viewController RequestMethod];
        }
    }
    else{


    }
}


- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    

    NSString *tempStr = _titlearr[index];
    NSDictionary *dic;
    dic = [UserModel defaultModel].tagDic[tempStr];
    RoomChildVC *vc;
    if ([((NSString *)dic[@"tag"]) containsString:@"新房"]) {

        vc = [[RoomChildVC alloc] initWithType:2];
    }else if([((NSString *)dic[@"tag"]) containsString:@"推荐"] || [((NSString *)dic[@"tag"]) containsString:@"关注"]) {

        vc = [[RoomChildVC alloc] initWithType:1];
    }else if([((NSString *)dic[@"tag"]) containsString:@"租房"]){

        vc = [[RoomChildVC alloc] initWithType:3];
    }else{

        vc = [[RoomChildVC alloc] initWithType:0];
    }
    vc.status = dic[@"tag"];
    vc.typeId = [NSString stringWithFormat:@"%@",dic[@"type_id"]];
    vc.param = [NSString stringWithFormat:@"%@",dic[@"param"]];
    vc.city = _city;
    
    __weak RoomChildVC *weakvc = vc;
    //新房项目
    vc.roomChildVCNewRoomProjectBlock = ^(NewRoomModel * _Nonnull model) {
      
        NewRoomProjectDetailVC *nextVC = [[NewRoomProjectDetailVC alloc] initWithProjectId:model.project_id];
        [self.navigationController pushViewController:nextVC animated:YES];
    };
    
    //二手房项目
    vc.roomChildVCSecRoomProjectBlock = ^(SecProjectModel * _Nonnull model) {
        
        SecRoomProjectDetailVC *nextVC = [[SecRoomProjectDetailVC alloc] initWithProjectId:model.project_id];
        
        nextVC.type = weakvc.typeId;
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    };
    //二手房房源详情
    vc.roomChildVCSecRoomHouseBlock = ^(SecHouseModel * _Nonnull model) {
      
        if ([model.type integerValue] == 1) {
            
            SecRoomHouseDetailVC *nextVC = [[SecRoomHouseDetailVC alloc] initWithHouseId:model.house_id city:self->_city];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if ([model.type integerValue] == 2){
            
            SecRoomStoreDetailVC *nextVC = [[SecRoomStoreDetailVC alloc] initWithHouseId:model.house_id city:self->_city];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            SecRoomOfficeDetailVC *nextVC = [[SecRoomOfficeDetailVC alloc] initWithHouseId:model.house_id city:self->_city];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    };
    
    //租房项目
    vc.roomChildVCRentRoomProjectBlock = ^(RentProjectModel * _Nonnull model) {
        
        RentRoomProjectDetailVC *nextVC = [[RentRoomProjectDetailVC alloc] initWithProjectId:model.project_id];
        
        nextVC.type = weakvc.typeId;
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    };
    
    vc.roomChildVCRentRoomHouseBlock = ^(RentHouseModel * _Nonnull model) {
      
        if ([model.type integerValue] == 1) {
            
            RentRoomHouseDetailVC *nextVC = [[RentRoomHouseDetailVC alloc] initWithHouseId:model.house_id city:self->_city];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if ([model.type integerValue] == 2){
            
            
        }else{
            
            
        }
    };
//    vc.roomChildVCRoomModelBlock = ^(RoomListModel *model) {
//
//        if ([dic[@"tag"] isEqualToString:@"关注"]) {
//
//            RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
//            if ([model.guarantee_brokerage integerValue] == 2) {
//
//                nextVC.brokerage = @"no";
//            }else{
//
//                if ([[UserModelArchiver unarchive].agent_identity integerValue] == 1) {
//
//                }else{
//
//                    nextVC.isRecommend = @"NO";
//                }
//                nextVC.brokerage = @"yes";
//            }
//
//            nextVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else{
//
//            RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
//            if ([model.guarantee_brokerage integerValue] == 2) {
//
//                nextVC.brokerage = @"no";
//            }else{
//
//                if ([model.sort integerValue] == 0 && [model.cycle integerValue] == 0){
//
//                    nextVC.isRecommend = @"NO";
//                }
//                else{
//
//                    if ([[UserModelArchiver unarchive].agent_identity integerValue] == 1) {
//
//                    }else{
//
//                        nextVC.isRecommend = @"NO";
//                    }
//                }
//                nextVC.brokerage = @"yes";
//            }
//
//            nextVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }
//    };
//
//    vc.roomChildVCSecModelBlock = ^(SecdaryAllTableModel *model) {
//
//        SecAllRoomDetailVC *nextVC = [[SecAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
//        nextVC.type = [model.type integerValue];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//
//    };
//
//    vc.roomChildVCAttentionSecModelBlock = ^(AttentionHouseModel *model) {
//
//        SecAllRoomDetailVC *nextVC = [[SecAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
//        nextVC.type = [model.type integerValue];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//

//
//    vc.roomChildVCAttentionSecComModelBlock = ^(AttetionComModel *model) {
//
//        SecComRoomDetailVC *nextVC = [[SecComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:_city];
//
//        nextVC.type = weakvc.typeId;
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCRecommendBlock = ^(RecommendInfoModel *model) {
//
//        RecommendInfoVC *vc = [[RecommendInfoVC alloc] initWithUrlStr:model.content_url titleStr:model.title imageUrl:model.img_url briefStr:model.desc];
//        [self.navigationController pushViewController:vc animated:YES];
//    };
//
//    vc.roomChildVCRentModelBlock = ^(RentingAllTableModel *model) {
//
//        RentingAllRoomDetailVC *nextVC = [[RentingAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
//        nextVC.type = [model.type integerValue];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCAttentionRentModelBlock = ^(AtteionRentingHouseModel *model) {
//
//        RentingAllRoomDetailVC *nextVC = [[RentingAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
//        nextVC.type = [model.type integerValue];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCRentComModelBlock = ^(RentingComModel *model) {
//
//        RentingComRoomDetailVC *nextVC = [[RentingComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:_city];
//        nextVC.type = weakvc.typeId;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCAttentionRentComModelBlock = ^(AttetionRentingComModel *model) {
//
//        RentingComRoomDetailVC *nextVC = [[RentingComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:_city];
//        nextVC.type = weakvc.typeId;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
    return vc;
    
    
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return _titlearr[index];
}


#pragma mark - WMPageControllerDataSource

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    return CGRectMake(0, NAVIGATION_BAR_HEIGHT+20*SIZE, 320*SIZE, 40*SIZE);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    return CGRectMake(0, NAVIGATION_BAR_HEIGHT+60*SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT- 60*SIZE);
    
}

@end
