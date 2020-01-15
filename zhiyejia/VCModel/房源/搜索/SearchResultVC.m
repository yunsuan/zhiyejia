//
//  SearchResultVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SearchResultVC.h"

#import "NewRoomCell.h"
#import "SecRoomCell.h"
#import "RentRoomCell.h"

#import "SecHouseCell.h"
#import "RentHouseCell.h"

@interface SearchResultVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _AllType;
    NSInteger _page;
    NSString *_city;
    NSString *_district;
    NSString *_price;
    NSString *_type;
    NSString *_tag;
    NSString *_houseType;
    NSString *_property_id;
    NSString *_asc;
    NSString *_urlString;
}
@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation SearchResultVC

- (instancetype)initWithType:(NSString *)type title:(NSString *)title city:(NSString *)city
{
    self = [super init];
    if (self) {
        
        self.title = title;
        _AllType = [type integerValue];
        _city = city;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    
//    _city = @"510100";
    if (_city.length) {
        
        [self RequestMethod];
    }else{
        
        if ([self.status isEqualToString:@"推荐"]) {
            
//            [self RequestMethod];
        }else if([self.status isEqualToString:@"关注"]){
            
//            [self RequestMethod];
        }
    }
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
    _page = 1;
    _asc = @"asc";
}


- (void)RequestMethod{
    
    if (_AllType == 0) {

        _urlString = HouseList_URL;
        if ([self.param isEqualToString:@"houseProject"]) {

            _urlString = HouseProjectList_URL;
        }
    }else if (_AllType == 1){

        if ([self.status isEqualToString:@"关注"]) {

            _urlString = UserFocusNews_URL;
        }else{

            _urlString = RecommendGetList_URL;
        }
    }else if(_AllType == 3){

        _urlString = RentProjectList_URL;
        if ([self.param isEqualToString:@"rent"]) {

            _urlString = RentHouseList_URL;
        }
    }else{

        _urlString = HomeProjectList_URL;
    }

    if (_page == 1) {

        _MainTableView.mj_footer.state = MJRefreshStateIdle;
    }

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];

    [dic setObject:@"asc" forKey:@"sort_type"];

    if (_city.length) {

        [dic setObject:_city forKey:@"city"];
    }else{

        [_MainTableView.mj_header endRefreshing];
        return;
    }
    if (_AllType == 0 && ![self.param isEqualToString:@"houseProject"]) {
        
        [dic setValue:self.title forKey:@"search_content"];
    }else{
        
        [dic setValue:self.title forKey:@"project_name"];
    }
    
    
    if (_AllType == 1) {

        if ([self.status isEqualToString:@"关注"]) {

            [dic removeObjectForKey:@"page"];
            [dic removeObjectForKey:@"sort_type"];
            [dic removeObjectForKey:@"city"];
        }
        
    }else{

        if ([self.param isEqualToString:@"houseProject"]) {

            if (self.typeId.length && [self.typeId integerValue]) {

                [dic setObject:self.typeId forKey:@"property_id"];
            }
        }else{

            if (self.typeId.length && [self.typeId integerValue]) {

                [dic setObject:self.typeId forKey:@"type"];
            }
        }

    }

    if (![_district isEqualToString:@"0"] && _district.length) {

        [dic setObject:_district forKey:@"district"];
    }
    if (![_price isEqualToString:@"0"] && _price) {

        [dic setObject:[NSString stringWithFormat:@"%@",_price] forKey:@"average_price"];
    }
    if (![_type isEqualToString:@"0"] && _type) {

        [dic setObject:[NSString stringWithFormat:@"%@",_type] forKey:@"property_id"];
    }
    if (_tag.length) {

        [dic setObject:[NSString stringWithFormat:@"%@",_tag] forKey:@"project_tags"];
    }
    if (_houseType.length) {

        [dic setObject:[NSString stringWithFormat:@"%@",_houseType] forKey:@"house_type"];
    }
    if (_property_id.length) {


    }

    [BaseRequest GET:_urlString parameters:dic success:^(id resposeObject) {

        [self.MainTableView.mj_header endRefreshing];

        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            [self->_dataArr removeAllObjects];
            if (self->_AllType == 0) {

                [self SetData:resposeObject[@"data"][@"data"]];
                if ([resposeObject[@"data"][@"data"] count] < 15) {

                    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }else if (self->_AllType == 1){

                if ([self.status isEqualToString:@"关注"]) {

                    [self SetData:resposeObject[@"data"]];
                    if ([resposeObject[@"data"] count] < 15) {

                        self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                }else{

                    [self SetData:resposeObject[@"data"]];
                    if ([resposeObject[@"data"] count] < 15) {

                        self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                }
            }else if (self->_AllType == 3){

                [self SetData:resposeObject[@"data"][@"data"]];
                if ([resposeObject[@"data"][@"data"] count] < 15) {

                    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }else{

                [self SetData:resposeObject[@"data"]];
                if ([resposeObject[@"data"] count] < 15) {

                    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }

        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        [self.MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}


- (void)RequestAddMethod{
    
    if (_AllType == 0) {
        
        _urlString = HouseList_URL;
        if ([self.param isEqualToString:@"houseProject"]) {
            
            _urlString = HouseProjectList_URL;
        }
    }else if (_AllType == 1){
        
        if ([self.status isEqualToString:@"关注"]) {
            
            _urlString = UserFocusNews_URL;
        }else{
            
            _urlString = RecommendGetList_URL;
        }
    }else if(_AllType == 3){
        
        _urlString = RentProjectList_URL;
        if ([self.param isEqualToString:@"rent"]) {
            
            _urlString = RentHouseList_URL;
        }
    }else{
        
        _urlString = HomeProjectList_URL;
    }

    _page += 1;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
//    [dic setObject:[UserModel defaultModel].agent_id forKey:@"agent_id"];

    if (_city.length) {

        [dic setObject:_city forKey:@"city"];
    }else{

        [_MainTableView.mj_footer endRefreshing];
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择城市"];
        return;
    }
    
    if (_AllType == 0 && ![self.param isEqualToString:@"houseProject"]) {
        
        [dic setValue:self.title forKey:@"search_content"];
    }else{
        
        [dic setValue:self.title forKey:@"project_name"];
    }

    if (_AllType == 1) {

        if ([self.status isEqualToString:@"关注"]) {

            [dic removeObjectForKey:@"page"];
            [dic removeObjectForKey:@"sort_type"];
            [dic removeObjectForKey:@"city"];
        }
    }else{

        if ([self.param isEqualToString:@"houseProject"]) {

            if (self.typeId.length && [self.typeId integerValue]) {

                [dic setObject:self.typeId forKey:@"property_id"];
            }
        }else{

            if (self.typeId.length && [self.typeId integerValue]) {

                [dic setObject:self.typeId forKey:@"type"];
            }
        }
    }

    if (_district.length && [_district isEqualToString:@"0"]) {

        [dic setObject:_district forKey:@"district"];
    }
    if (![_price isEqualToString:@"0"] && _price) {

        [dic setObject:[NSString stringWithFormat:@"%@",_price] forKey:@"average_price"];
    }
    if (![_type isEqualToString:@"0"] && _type) {

        [dic setObject:[NSString stringWithFormat:@"%@",_type] forKey:@"property_id"];
    }
    if (_tag.length) {

        [dic setObject:[NSString stringWithFormat:@"%@",_tag] forKey:@"project_tags"];
    }
    if (_houseType.length) {

        [dic setObject:[NSString stringWithFormat:@"%@",_houseType] forKey:@"house_type"];
    }
    [dic setObject:_asc forKey:@"sort_type"];

    [BaseRequest GET:_urlString parameters:dic success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {

            if (self->_AllType == 0) {

                [self SetData:resposeObject[@"data"][@"data"]];
                if ([resposeObject[@"data"][@"data"] count] < 15) {

                    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }else if (self->_AllType == 1){

                if ([self.status isEqualToString:@"关注"]) {

                    [self SetData:resposeObject[@"data"]];
                    if ([resposeObject[@"data"] count] < 15) {

                        self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                }else{

                    [self SetData:resposeObject[@"data"][@"data"]];
                    if ([resposeObject[@"data"][@"data"] count] < 15) {

                        self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                }
            }else if (self->_AllType == 3){

                [self SetData:resposeObject[@"data"][@"data"]];
                if ([resposeObject[@"data"] count] < 15) {

                    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }else{

                [self SetData:resposeObject[@"data"]];
                if ([resposeObject[@"data"] count] < 15) {

                    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }
        }else{

            self->_page -= 1;
            [self showContent:resposeObject[@"msg"]];
            [self.MainTableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {

        self->_page -= 1;
        [self showContent:@"网络错误"];
        [self.MainTableView.mj_footer endRefreshing];
    }];
}


- (void)SetData:(NSArray *)data{
        
    if (_AllType == 0) {
        
        if ([self.param isEqualToString:@"house"]) {
            
            for (int i = 0; i < data.count; i++) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
                [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass:[NSNull class]]) {
                        
                        if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                            
                            [tempDic setObject:@[] forKey:key];
                        }else{
                            
                            [tempDic setObject:@"" forKey:key];
                        }
                    }else{
                        
                        if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                            
                            
                        }else{
                            
                            [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                        }
                    }
                }];
                SecHouseModel *model = [[SecHouseModel alloc] initWithDictionary:tempDic];
                [_dataArr addObject:model];
            }
        }else{
            
            for (int i = 0; i < data.count; i++) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
                [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass:[NSNull class]]) {
                        
                        [tempDic setObject:@"" forKey:key];
                    }
                    [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }];
                
                SecProjectModel *model = [[SecProjectModel alloc] initWithDictionary:tempDic];
                [_dataArr addObject:model];
            }
        }
    }else if (_AllType == 1){
        
        if ([self.status isEqualToString:@"关注"]) {
            
            for (int i = 0; i < data.count; i++) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
                [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass:[NSNull class]]) {
                        
                        [tempDic setObject:@"" forKey:key];
                    }
                }];
                
                if (tempDic[@"project_id"]) {
                    
                    if ([tempDic[@"type"] integerValue] == 0) {
                        
                        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
                        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                            
                            if ([obj isKindOfClass:[NSNull class]]) {
                                
                                [tempDic setObject:@"" forKey:key];
                            }
                        }];
                        
                        NewRoomModel *model = [[NewRoomModel alloc] initWithDictionary:tempDic];
                        [_dataArr addObject:model];
                    }else if ([tempDic[@"type"] integerValue] == 1){
                        
                        SecProjectModel *model = [[SecProjectModel alloc] initWithDictionary:tempDic];
                        [_dataArr addObject:model];
                    }else{
                        
                        RentProjectModel *model = [[RentProjectModel alloc] initWithDictionary:tempDic];
                        [_dataArr addObject:model];
                    }
                }else{
                    
                    if ([tempDic[@"focus_type"] integerValue] == 0) {
                        
                        
                    }else if ([tempDic[@"focus_type"] integerValue] == 1){
                        
                        SecHouseModel *model = [[SecHouseModel alloc] initWithDictionary:tempDic];
                        [_dataArr addObject:model];
                    }else{
                        
                        RentHouseModel *model = [[RentHouseModel alloc] initWithDictionary:tempDic];
                        [_dataArr addObject:model];
                    }
                }
            }
        }else{
            
            for (int i = 0; i < data.count; i++) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
                [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass:[NSNull class]]) {
                        
                        [tempDic setObject:@"" forKey:key];
                    }
                }];
                
//                RecommendInfoModel *model = [[RecommendInfoModel alloc] initWithDictionary:tempDic];
//                [_dataArr addObject:model];
            }
        }
    }else if (_AllType == 3){
        
        if ([self.param isEqualToString:@"rent"]) {
            
            for (int i = 0; i < data.count; i++) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
                [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass:[NSNull class]]) {
                        
                        if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                            
                            [tempDic setObject:@[] forKey:key];
                        }else{
                            
                            [tempDic setObject:@"" forKey:key];
                        }
                    }else{
                        
                        if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                            
                            
                        }else{
                            
                            [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                        }
                    }
                }];
                RentHouseModel *model = [[RentHouseModel alloc] initWithDictionary:tempDic];
                [_dataArr addObject:model];
            }
        }else{
            
            for (int i = 0; i < data.count; i++) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
                [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass:[NSNull class]]) {
                        
                        [tempDic setObject:@"" forKey:key];
                    }
                    [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }];
                
                RentProjectModel *model = [[RentProjectModel alloc] initWithDictionary:tempDic];
                [_dataArr addObject:model];
            }
        }
    }else{
        
        for (int i = 0; i < data.count; i++) {
            
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
            [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }];
            
            NewRoomModel *model = [[NewRoomModel alloc] initWithDictionary:tempDic];
            [_dataArr addObject:model];
        }
    }
    
    [_MainTableView reloadData];
}

#pragma mark -- Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (_AllType) {
        case 0:
        {
            if ([self.param isEqualToString:@"house"]) {

                SecHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseCell"];
                if (!cell) {

                    cell = [[SecHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecHouseCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                SecHouseModel *model = _dataArr[indexPath.row];
                cell.model = model;

                return cell;
            }else{

                SecRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecRoomCell"];
                if (!cell) {

                    cell = [[SecRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecRoomCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = _dataArr[indexPath.row];

                return cell;
            }
            break;
        }
        case 1:{

            if ([self.status isEqualToString:@"关注"]) {

                if ([_dataArr[indexPath.row] isKindOfClass:[RentProjectModel class]]) {

                    RentRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentRoomCell"];
                    if (!cell) {

                        cell = [[RentRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentRoomCell"];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;

                    cell.model = _dataArr[indexPath.row];
                    return cell;
                    break;
                }else if([_dataArr[indexPath.row] isKindOfClass:[SecProjectModel class]]){

                    SecRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecRoomCell"];
                    if (!cell) {

                        cell = [[SecRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecRoomCell"];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;

                    cell.model = _dataArr[indexPath.row];
                    return cell;
                    break;
                }else if([_dataArr[indexPath.row] isKindOfClass:[SecHouseModel class]]){

                    SecHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseCell"];
                    if (!cell) {

                        cell = [[SecHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecHouseCell"];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;

                    cell.model = _dataArr[indexPath.row];
                    return cell;
                    break;
                }else if ([_dataArr[indexPath.row] isKindOfClass:[RentHouseModel class]]){

                    RentHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentHouseCell"];
                    if (!cell) {

                        cell = [[RentHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentHouseCell"];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;

                    cell.model = _dataArr[indexPath.row];
                    return cell;
                    break;
                }else{

                    NewRoomModel *model = _dataArr[indexPath.row];
                    NewRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomCell"];
                    if (!cell) {
                        
                        cell = [[NewRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomCell"];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                                
                    cell.model = _dataArr[indexPath.row];
                    return cell;
                }
            }else{

//                RecommendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendInfoCell"];
//                if (!cell) {
//
//                    cell = [[RecommendInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendInfoCell"];
//                }
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                cell.model = _dataArr[indexPath.row];
//                return cell;
            }
        }
        case 2:{

    
            NewRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomCell"];
            if (!cell) {
        
                cell = [[NewRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
            cell.model = _dataArr[indexPath.row];
            return cell;
            break;
        }
        case 3:{

            if ([self.param isEqualToString:@"rent"]) {

                RentHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentHouseCell"];
                if (!cell) {

                    cell = [[RentHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentHouseCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                cell.model = _dataArr[indexPath.row];

                return cell;
            }else{

                RentRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentRoomCell"];
                if (!cell) {

                    cell = [[RentRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentRoomCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                cell.model = _dataArr[indexPath.row];

                return cell;
            }
            break;
        }
        default:
            return [[UITableViewCell alloc] init];
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_AllType == 0) {

        if ([self.param isEqualToString:@"house"]) {

            SecHouseModel *model = _dataArr[indexPath.row];
            
        }else{

            SecProjectModel *model = _dataArr[indexPath.row];

            
        }
    }else if (_AllType == 1){

        

    }else if(_AllType == 3){

        if ([self.param isEqualToString:@"rent"]) {

            RentHouseModel *model = _dataArr[indexPath.row];

            
        }else{

            RentProjectModel *model = _dataArr[indexPath.row];


        }
    }else{

        NewRoomModel *model = _dataArr[indexPath.row];
        
    }
}

- (void)initUI{
    
    self.view.backgroundColor = CLLineColor;
    
    self.navBackgroundView.hidden = YES;
    
    _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    
    _MainTableView.rowHeight = UITableViewAutomaticDimension;
    _MainTableView.estimatedRowHeight = 120 *SIZE;
    
    _MainTableView.backgroundColor = CLWhiteColor;
    _MainTableView.delegate = self;
    _MainTableView.dataSource = self;
    _MainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_MainTableView];
    
    _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{

        self->_page = 1;
        [self RequestMethod];
    }];

    _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{

        [self RequestAddMethod];
    }];
}

@end
