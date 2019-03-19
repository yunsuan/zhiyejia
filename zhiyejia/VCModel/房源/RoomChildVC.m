//
//  RoomChildVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RoomChildVC.h"

@interface RoomChildVC ()<UITableViewDelegate,UITableViewDataSource>
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

@implementation RoomChildVC

- (instancetype)initWithType:(NSInteger)type
{
    self = [super init];
    if (self) {
        
        _AllType = type;
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

        _urlString = HouseHouseList_URL;
        if ([self.param isEqualToString:@"houseProject"]) {

            _urlString = HouseProjectList_URL;
        }
    }else if (_AllType == 1){

        if ([self.status isEqualToString:@"关注"]) {

//            _urlString = UserFocusNews_URL;
        }else{

//            _urlString = ProjectRecommendInfo_URL;
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
        
        _urlString = HouseHouseList_URL;
        if ([self.param isEqualToString:@"houseProject"]) {
            
            _urlString = HouseProjectList_URL;
        }
    }else if (_AllType == 1){
        
        if ([self.status isEqualToString:@"关注"]) {
            
            //            _urlString = UserFocusNews_URL;
        }else{
            
            //            _urlString = ProjectRecommendInfo_URL;
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
                        
//                        RoomListModel *model = [[RoomListModel alloc] initWithDictionary:tempDic];
//
//                        [_dataArr addObject:model];
                    }else if ([tempDic[@"type"] integerValue] == 1){
                        
//                        AttetionComModel *model = [[AttetionComModel alloc] initWithDictionary:tempDic];
//                        [_dataArr addObject:model];
                        
                    }else{
                        
//                        AttetionRentingComModel *model = [[AttetionRentingComModel alloc] initWithDictionary:tempDic];
//                        [_dataArr addObject:model];
                    }
                }else{
                    
                    if ([tempDic[@"focus_type"] integerValue] == 0) {
                        
                        
                    }else if ([tempDic[@"focus_type"] integerValue] == 1){
                        
//                        AttentionHouseModel *model = [[AttentionHouseModel alloc] initWithDictionary:tempDic];
//                        [_dataArr addObject:model];
                        
                    }else{
                        
//                        AtteionRentingHouseModel *model = [[AtteionRentingHouseModel alloc] initWithDictionary:tempDic];
//                        [_dataArr addObject:model];
                        
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
//                model.price_change = tempDic[@"price_change"];
//                model.img_url = tempDic[@"img_url"];
//                model.house_id = tempDic[@"house_id"];
//                model.title = tempDic[@"title"];
//                model.describe = tempDic[@"describe"];
//                model.price = tempDic[@"price"];
//                model.unit_price = tempDic[@"unit_price"];
//                model.property_type = tempDic[@"property_type"];
//                model.store_name = tempDic[@"store_name"];
//                model.project_tags = [NSMutableArray arrayWithArray:tempDic[@"project_tags"]];
//                model.house_tags = [NSMutableArray arrayWithArray:tempDic[@"house_tags"]];
//                model.type = tempDic[@"type"];
//                model.info_id = tempDic[@"info_id"];
//                model.level = tempDic[@"level"];
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

//                return [[UITableViewCell alloc] init];
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
//        case 1:{
//
//            if ([self.status isEqualToString:@"关注"]) {
//
//                if ([_dataArr[indexPath.row] isKindOfClass:[AttetionRentingComModel class]]) {
//
//                    AttentionRentingComCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttentionRentingComCell"];
//                    if (!cell) {
//
//                        cell = [[AttentionRentingComCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AttentionRentingComCell"];
//                    }
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                    cell.model = _dataArr[indexPath.row];
//                    return cell;
//                    break;
//                }else if([_dataArr[indexPath.row] isKindOfClass:[AttetionComModel class]]){
//
//                    AttentionComCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttentionComCell"];
//                    if (!cell) {
//
//                        cell = [[AttentionComCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AttentionComCell"];
//                    }
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                    cell.model = _dataArr[indexPath.row];
//                    return cell;
//                    break;
//                }else if([_dataArr[indexPath.row] isKindOfClass:[AttentionHouseModel class]]){
//
//                    AttentionHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttentionHouseCell"];
//                    if (!cell) {
//
//                        cell = [[AttentionHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AttentionHouseCell"];
//                    }
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                    cell.model = _dataArr[indexPath.row];
//                    return cell;
//                    break;
//                }else if ([_dataArr[indexPath.row] isKindOfClass:[AtteionRentingHouseModel class]]){
//
//                    AttentionRentingHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttentionRentingHouseCell"];
//                    if (!cell) {
//
//                        cell = [[AttentionRentingHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AttentionRentingHouseCell"];
//                    }
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                    cell.model = _dataArr[indexPath.row];
//                    return cell;
//                    break;
//                }else{
//
//                    RoomListModel *model = _dataArr[indexPath.row];
//                    if ([model.guarantee_brokerage integerValue] == 2) {
//
//                        static NSString *CellIdentifier = @"CompanyCell";
//
//                        CompanyCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//                        if (!cell) {
//                            cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//                        }
//                        [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
//                        [cell settagviewWithdata:@[model.property_tags,model.project_tags]];
//                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                        return cell;
//
//                    }else{
//
//                        static NSString *CellIdentifier = @"PeopleCell";
//
//                        PeopleCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//                        if (!cell) {
//                            cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//                        }
//                        [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
//
//                        cell.statusImg.hidden = YES;
//                        cell.surelab.hidden = YES;
//
//                        NSArray *project_tags = model.project_tags?model.project_tags:@[];
//                        NSArray *property_tags = model.property_tags?model.property_tags:@[];
//                        [cell settagviewWithdata:@[property_tags,project_tags]];
//                        cell.getLevel.hidden = YES;
//                        //                        if (model.sort) {
//                        //
//                        //                            cell.rankView.rankL.text = [NSString stringWithFormat:@"佣金:第%@名",model.sort];
//                        //                        }else{
//                        //
//                        //                            cell.rankView.rankL.text = [NSString stringWithFormat:@"佣金:无排名"];
//                        //                        }
//                        //                        [cell.rankView.rankL mas_remakeConstraints:^(MASConstraintMaker *make) {
//                        //
//                        //                            make.left.equalTo(cell.rankView).offset(0);
//                        //                            make.top.equalTo(cell.rankView).offset(0);
//                        //                            make.height.equalTo(@(10 *SIZE));
//                        //                            make.width.equalTo(@(cell.rankView.rankL.mj_textWith + 5 *SIZE));
//                        //                        }];
//                        //                        if ([model.brokerSortCompare integerValue] == 0) {
//                        //
//                        //                            cell.rankView.statusImg.image = nil;
//                        //                        }else if ([model.brokerSortCompare integerValue] == 1){
//                        //
//                        //                            cell.rankView.statusImg.image = [UIImage imageNamed:@"rising"];
//                        //                        }else if ([model.brokerSortCompare integerValue] == 2){
//                        //
//                        //                            cell.rankView.statusImg.image = [UIImage imageNamed:@"falling"];
//                        //                        }
//                        //                        [cell.getLevel SetImage:[UIImage imageNamed:@"lightning_1"] selectImg:[UIImage imageNamed:@"lightning"] num:[model.cycle integerValue]];
//
//                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                        return cell;
//                    }
//                }
//            }else{
//
//                RecommendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendInfoCell"];
//                if (!cell) {
//
//                    cell = [[RecommendInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendInfoCell"];
//                }
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                cell.model = _dataArr[indexPath.row];
//                return cell;
//            }
//        }
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
            if (self.roomChildVCSecRoomHouseBlock) {
                
                self.roomChildVCSecRoomHouseBlock(model);
            }
//            SecdaryAllTableModel *model = _dataArr[indexPath.row];
//
//            if (self.roomChildVCSecModelBlock) {
//
//                self.roomChildVCSecModelBlock(model);
//            }
        }else{

            SecProjectModel *model = _dataArr[indexPath.row];

            if (self.roomChildVCSecRoomProjectBlock) {

                self.roomChildVCSecRoomProjectBlock(model);
            }
        }
    }else if (_AllType == 1){

        if ([self.status isEqualToString:@"关注"]) {

//            if ([_dataArr[indexPath.row] isKindOfClass:[AttetionRentingComModel class]]) {

//                AttetionRentingComModel *model = _dataArr[indexPath.row];
//                if (self.roomChildVCAttentionRentComModelBlock) {
//
//                    self.roomChildVCAttentionRentComModelBlock(model);
//                }
//            }else if([_dataArr[indexPath.row] isKindOfClass:[AttetionComModel class]]){

//                AttetionComModel *model = _dataArr[indexPath.row];
//                if (self.roomChildVCAttentionSecComModelBlock) {
//
//                    self.roomChildVCAttentionSecComModelBlock(model);
//                }
//            }else if([_dataArr[indexPath.row] isKindOfClass:[AttentionHouseModel class]]){

//                AttentionHouseModel *model = _dataArr[indexPath.row];
//
//                if ([model.detail_get integerValue] == 1) {
//
//                    if (self.roomChildVCAttentionSecModelBlock) {
//
//                        self.roomChildVCAttentionSecModelBlock(model);
//                    }
//                }

//            }else if ([_dataArr[indexPath.row] isKindOfClass:[AtteionRentingHouseModel class]]){

//                AtteionRentingHouseModel *model = _dataArr[indexPath.row];
//                if ([model.detail_get integerValue] == 1) {
//
//                    if (self.roomChildVCAttentionRentModelBlock) {
//
//                        self.roomChildVCAttentionRentModelBlock(model);
//                    }
//                }
//            }else{

                NewRoomModel *model = _dataArr[indexPath.row];
                if (self.roomChildVCNewRoomProjectBlock) {
                    
                    self.roomChildVCNewRoomProjectBlock(model);
//                }
            }
        }else{

//            RecommendInfoModel *model = _dataArr[indexPath.row];
//
//            if (self.roomChildVCRecommendBlock) {
//
//                self.roomChildVCRecommendBlock(model);
//            }
        }
    }else if(_AllType == 3){

        if ([self.param isEqualToString:@"rent"]) {

            RentHouseModel *model = _dataArr[indexPath.row];

            if (self.roomChildVCRentRoomHouseBlock) {

                self.roomChildVCRentRoomHouseBlock(model);
            }
        }else{

            RentProjectModel *model = _dataArr[indexPath.row];

            if (self.roomChildVCRentRoomProjectBlock) {

                self.roomChildVCRentRoomProjectBlock(model);
            }
        }
    }else{

        NewRoomModel *model = _dataArr[indexPath.row];
        if (self.roomChildVCNewRoomProjectBlock) {
            
            self.roomChildVCNewRoomProjectBlock(model);
        }
    }
}

- (void)initUI{
    
    self.view.backgroundColor = CLLineColor;
    
    self.navBackgroundView.hidden = YES;
    
    _MainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_Width, SCREEN_Height - 46 - 46 *SIZE - STATUS_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    
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
