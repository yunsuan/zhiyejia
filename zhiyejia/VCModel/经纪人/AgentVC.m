//
//  AgentVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentVC.h"

#import "AgentDetailVC.h"

#import "AgentCell.h"

#import "BoxWithOutUnlimitedView.h"

#import <BMKLocationKit/BMKLocationComponent.h>

@interface AgentVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,BMKLocationManagerDelegate>
{
    
    NSInteger _page;
    
    NSString *_latitude;
    NSString *_longitude;
    NSString *_city;
    NSString *_search;
    NSString *_num_sort;
    NSString *_distance_sort;
    
    NSMutableArray *_cityArr;
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITextField *searchTF;

@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) UIButton *cityBtn;

@property (nonatomic, strong) UIButton *distanceBtn;

@property (nonatomic, strong) UIButton *seeBtn;

@property (nonatomic, strong) BoxWithOutUnlimitedView *boxView;

@property (nonatomic, strong) UITableView *table;

@end

@implementation AgentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    
    //判断城市数组，没有就重新获取一次
    if (!_cityArr.count) {
        
        [self CityListRequest];
    }else{
        
        //默认一个城市
        _city = [NSString stringWithFormat:@"%@",_cityArr[0][@"city_code"]];
        [_cityBtn setTitle:[NSString stringWithFormat:@"%@",_cityArr[0][@"city_name"]] forState:UIControlStateNormal];
        [self RequestMethod];
    }
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"goHome" object:nil];
    _page = 1;
    _num_sort = @"";
    _distance_sort = @"1";
    
    _dataArr = [@[] mutableCopy];
    
    _cityArr = [@[] mutableCopy];
    _cityArr = [UserModel defaultModel].cityArr;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"]) {
        
        _latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];
        _longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
    }
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {

        [self StartLocation];
    }else{
        
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
    
    BMKLocationManager *locationManager = [[BMKLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    locationManager.pausesLocationUpdatesAutomatically = NO;
    locationManager.allowsBackgroundLocationUpdates = NO;// YES的话是可以进行后台定位的，但需要项目配置，否则会报错，具体参考开发文档
    locationManager.locationTimeout = 10;
    locationManager.reGeocodeTimeout = 10;

    //开始定位
    [locationManager startUpdatingLocation];
}

- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error{
    
    _latitude = [NSString stringWithFormat:@"%f",location.location.coordinate.latitude];
    _longitude = [NSString stringWithFormat:@"%f",location.location.coordinate.longitude];
    NSLog(@"%@",error);
}

- (void)BMKLocationManager:(BMKLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status != kCLAuthorizationStatusNotDetermined) {
        
        [self StartLocation];
    }
}

- (void)CityListRequest{
    
    [BaseRequest GET:OpenCity_URL parameters:nil success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {

            self->_cityArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            [self SetCity:self->_cityArr];
            if (self->_cityArr.count) {
                
                self->_city = [NSString stringWithFormat:@"%@",self->_cityArr[0][@"city_code"]];
                [self->_cityBtn setTitle:[NSString stringWithFormat:@"%@",self->_cityArr[0][@"city_name"]] forState:UIControlStateNormal];
            }else{
                
                [self RequestMethod];
            }
        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
    }];
}

- (void)SetCity:(NSArray *)data{
    
    [UserModel defaultModel].cityArr = [NSMutableArray arrayWithArray:data];
    [UserModelArchiver archive];
}

- (void)RequestMethod{
    
    _page = 1;
    _table.mj_footer.state = MJRefreshStateIdle;
    
    if (!_city.length) {
        
        [self showContent:@"请选择城市"];
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"city":_city,@"page":@(_page)}];
    
    if (_search.length) {
        
        [dic setValue:_search forKey:@"search"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"]) {
        
        [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"] forKey:@"latitude"];
        [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"] forKey:@"longitude"];
    }
    if (_num_sort.length) {
        
        [dic setValue:_num_sort forKey:@"num_sort"];
    }
    if (_distance_sort.length) {
        
        [dic setValue:_distance_sort forKey:@"distance_sort"];
    }
    
    
    if ([UserModel defaultModel].token) {
        
        [dic setValue:[UserModel defaultModel].agent_id forKey:@"home_agent_id"];
    }
    [BaseRequest GET:GetAgentList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            [self->_table reloadData];
            [self->_table.mj_header endRefreshing];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
                
            }else{
                
                [self->_dataArr removeAllObjects];
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self->_table.mj_header endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self->_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
 
    if (!_city.length) {
        
        [self showContent:@"请选择城市"];
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"city":_city,@"page":@(_page)}];
    
    if (_search.length) {
        
        [dic setValue:_search forKey:@"search"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"]) {
        
        [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"] forKey:@"latitude"];
        [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"] forKey:@"longitude"];
    }
    if (_num_sort.length) {
        
        [dic setValue:_num_sort forKey:@"num_sort"];
    }
    if (_distance_sort.length) {
        
        [dic setValue:_distance_sort forKey:@"distance_sort"];
    }
    if ([UserModel defaultModel].token) {
        
        [dic setValue:[UserModel defaultModel].agent_id forKey:@"home_agent_id"];
    }
    [BaseRequest GET:GetAgentList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self->_table.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"][@"data"]];
                
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            self->_page -= 1;
            [self->_table.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        self->_page -= 1;
        [self->_table.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    
    [_table reloadData];
}

- (void)ActionSearchBtn:(UIButton *)btn{
    
    _page = 1;
    _cityBtn.selected = NO;
    [self.boxView removeFromSuperview];
    
    _search = _searchTF.text;
    [self RequestMethod];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    switch (btn.tag) {
        case 1:
        {
            NSMutableArray *tempArr = [@[] mutableCopy];
            for (int i = 0; i < _cityArr.count; i++) {
                
                [tempArr addObject:@{@"id":_cityArr[i][@"city_code"],@"param":_cityArr[i][@"city_name"]}];
            }
            self.boxView.dataArr = [NSMutableArray arrayWithArray:tempArr];
            [tempArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj[@"id"] integerValue] == [_city integerValue]) {
                    
                    tempArr[idx] = @(1);
                }else{
                    
                    tempArr[idx] = @(0);
                }
//                if (idx == 0) {
//
//                    tempArr[idx] = @(1);
//                }else{
//
//                    tempArr[idx] = @(0);
//                }
            }];
            self.boxView.selectArr = [NSMutableArray arrayWithArray:tempArr];
            [self.boxView.mainTable reloadData];
            [[UIApplication sharedApplication].keyWindow addSubview:self.boxView];
            break;
        }
        case 2:{
            
            _page = 1;
            _cityBtn.selected = NO;
            _seeBtn.selected = NO;
            if ([_distance_sort integerValue] == 1) {
                
                _distance_sort = @"2";
            }else{
                
                _distance_sort = @"1";
            }
            _num_sort = @"";
            [self RequestMethod];
            [self.boxView removeFromSuperview];
            
            break;
        }
        case 3:{
            
            _page = 1;
            _cityBtn.selected = NO;
            _distanceBtn.selected = NO;
            [self.boxView removeFromSuperview];
            if ([_num_sort integerValue] == 2) {
                
                _num_sort = @"1";
            }else{
                
                _num_sort = @"2";
            }
            _distance_sort = @"";
            [self RequestMethod];
            break;
        }
        
        default:
            break;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    _cityBtn.selected = NO;
    [self.boxView removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    _page = 1;
    
    _search = _searchTF.text;
    [self RequestMethod];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCell"];
    if (!cell) {
        
        cell = [[AgentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AgentCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.agentCellPhoneBtnBlock = ^(NSInteger idx) {
      
        NSString *phone = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"tel"]];
        if (phone.length) {
            
            //获取目标号码字符串,转换成URL
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
            //调用系统方法拨号
            [[UIApplication sharedApplication] openURL:url];
        }else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
        }
    };
    
    cell.agentCellAttentBtnBlock = ^(NSInteger idx) {
      
        if ([UserModel defaultModel].token.length) {
        
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"agent_id":self->_dataArr[indexPath.row][@"agent_id"]}];
            if ([self->_dataArr[indexPath.row][@"is_focus"] integerValue] == 1) {
                
                [dic setValue:@"0" forKey:@"is_focus"];
            }else{
                
                [dic setValue:@"1" forKey:@"is_focus"];
            }
            
            [BaseRequest POST:HomeFocusOperation_URL parameters:dic success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self->_dataArr[indexPath.row]];
                    if ([tempDic[@"is_focus"] integerValue] == 1) {
                        
                        [tempDic setValue:@"0" forKey:@"is_focus"];
                        [tempDic setValue:[NSString stringWithFormat:@"%ld",[tempDic[@"focus_num"] integerValue] - 1] forKey:@"focus_num"];
                    }else{
                        
                        [tempDic setValue:@"1" forKey:@"is_focus"];
                        [tempDic setValue:[NSString stringWithFormat:@"%ld",[tempDic[@"focus_num"] integerValue] + 1] forKey:@"focus_num"];
                    }
                    [self->_dataArr replaceObjectAtIndex:indexPath.row withObject:tempDic];
                    [self->_table reloadData];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [self showContent:@"网络错误"];
            }];
        }else{
            
            [self GotoLogin];
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [BaseRequest POST:AddAgentBrowseNum_URL parameters:@{@"agent_id":[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"agent_id"]]} success:^(id  _Nonnull resposeObject) {
        
        AgentDetailVC *nextVC = [[AgentDetailVC alloc] initWithAgentId:[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"agent_id"]]];
        nextVC.agentDetailVCBlock = ^(NSString * str) {
          
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self->_dataArr[indexPath.row]];
            [tempDic setValue:str forKey:@"is_focus"];
            [self->_dataArr replaceObjectAtIndex:indexPath.row withObject:tempDic];
            [self->_table reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    } failure:^(NSError * _Nonnull error) {
       
        AgentDetailVC *nextVC = [[AgentDetailVC alloc] initWithAgentId:[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"agent_id"]]];
        nextVC.agentDetailVCBlock = ^(NSString * str) {
          
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self->_dataArr[indexPath.row]];
            [tempDic setValue:str forKey:@"is_focus"];
            [self->_dataArr replaceObjectAtIndex:indexPath.row withObject:tempDic];
            [self->_table reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
}




- (void)initUI{
    
    self.titleLabel.text = @"经纪人";
    self.leftButton.hidden = YES;
    
    self.view.backgroundColor = CLWhiteColor;
    
    _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(15 *SIZE, NAVIGATION_BAR_HEIGHT + 5 *SIZE, 265 *SIZE, 30 *SIZE)];
    _searchTF.backgroundColor = CLLineColor;
    _searchTF.delegate = self;
    _searchTF.keyboardType = UIKeyboardTypeWebSearch;
    _searchTF.placeholder = @"经纪人名/云算编号";
    _searchTF.font = FONT(13 *SIZE);
//    _searchTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 *SIZE, 40 *SIZE)];
//    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_searchTF];
        
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame = CGRectMake(290 *SIZE, NAVIGATION_BAR_HEIGHT + 5 *SIZE, 60 *SIZE, 30 *SIZE);
    _searchBtn.layer.cornerRadius = 5 *SIZE;
    _searchBtn.clipsToBounds = YES;
    _searchBtn.titleLabel.font = FONT(13 *SIZE);
    [_searchBtn setBackgroundColor:CLBlueBtnColor];
    [_searchBtn addTarget:self action:@selector(ActionSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.view addSubview:_searchBtn];
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_Width / 3 * i, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width / 3, 40 *SIZE);
        btn.tag = i + 1;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        switch (i) {
            case 0:
            {
                [btn setTitle:@"城市" forState:UIControlStateNormal];
                [btn setTitleColor:CL86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _cityBtn = btn;
                [self.view addSubview:_cityBtn];
                break;
            }
            case 1:
            {
                [btn setTitle:@"附近" forState:UIControlStateNormal];
                [btn setTitleColor:CL86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _distanceBtn = btn;
                [self.view addSubview:_distanceBtn];
                break;
            }
            case 2:
            {
                [btn setTitle:@"带看量" forState:UIControlStateNormal];
                [btn setTitleColor:CL86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _seeBtn = btn;
                [self.view addSubview:_seeBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 80 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - 80 *SIZE) style:UITableViewStylePlain];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
       
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",self->_latitude] forKey:@"latitude"];
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",self->_longitude] forKey:@"longitude"];
        self->_page = 1;
        [self RequestMethod];
    }];
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
       
        self->_page += 1;
        [self RequestAddMethod];
    }];
}

- (BoxWithOutUnlimitedView *)boxView{
    
    if (!_boxView) {
        
        _boxView = [[BoxWithOutUnlimitedView alloc] initWithFrame:CGRectMake(0, 81 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - (81 *SIZE + NAVIGATION_BAR_HEIGHT))];
        WS(weakSelf);
        SS(strongSelf);
        _boxView.boxWithOutUnlimitedViewConfirmBtnBlock = ^(NSString *ID,NSString *str) {
            
            self->_page = 1;
            strongSelf->_cityBtn.selected = NO;
            [strongSelf->_cityBtn setTitle:str forState:UIControlStateNormal];
            strongSelf->_city = [NSString stringWithFormat:@"%@",ID];
            
            [weakSelf.boxView removeFromSuperview];
            [weakSelf RequestMethod];
        };

        _boxView.boxWithOutUnlimitedViewCancelBtnBlock = ^{

            strongSelf->_cityBtn.selected = NO;
        };
    }
    return _boxView;
}

@end
