//
//  SecComAllRoomListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecComAllRoomListVC.h"

#import "SecRoomHouseDetailVC.h"
#import "SecRoomStoreDetailVC.h"
#import "SecRoomOfficeDetailVC.h"

#import "SecHouseCell.h"

@interface SecComAllRoomListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _page;
    NSMutableArray *_dataArr;
    NSString *_city;
    NSString *_projectId;
}
@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation SecComAllRoomListVC

- (instancetype)initWithProjectId:(NSString *)projectId city:(NSString *)city
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
        if (_city.length) {
            
            _city = city;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDateSouce];
    [self initUI];
    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
    [self RequestMethod];
}

-(void)initDateSouce
{
    
    _dataArr = [@[] mutableCopy];
    _page = 1;
}

- (void)SetData:(NSArray *)data{
    
//    if (data.count < 15) {
//
//        self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
//    }else{
//
//        [self.MainTableView.mj_footer endRefreshing];
//    }
    
    [self.MainTableView.mj_footer endRefreshing];
    
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
    
    [self.MainTableView reloadData];
}

- (void)RequestMethod{
    
    if (_page == 1) {
        
        self.MainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    if (_city.length) {
        
        [dic setObject:_city forKey:@"city"];
    }
    [dic setObject:_projectId forKey:@"project_id"];
//    [dic setObject:[UserModelArchiver unarchive].agent_id forKey:@"agent_id"];
    [BaseRequest GET:HouseList_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self.MainTableView.mj_header endRefreshing];
            [_dataArr removeAllObjects];
            [self SetData:resposeObject[@"data"][@"data"]];
            
        }else{
            
             [self.MainTableView.mj_header endRefreshing];
            [self showContent:resposeObject[@"msg"]];
           
        }
        [_MainTableView reloadData];
    } failure:^(NSError *error) {
        
        [self.MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
    
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    if (_city.length) {
        
        [dic setObject:_city forKey:@"city"];
    }
    [dic setObject:_projectId forKey:@"project_id"];
//    [dic setObject:[UserModelArchiver unarchive].agent_id forKey:@"agent_id"];
    [BaseRequest GET:HouseList_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
//                [self.MainTableView.mj_footer endRefreshing];
            }else{
                
                self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            _page -= 1;
            [self showContent:resposeObject[@"msg"]];
            [self.MainTableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [self showContent:@"网络错误"];
        [self.MainTableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SecHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseCell"];
    if (!cell) {

        cell = [[SecHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecHouseCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.model = _dataArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SecHouseModel *model = _dataArr[indexPath.row];
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
}

- (void)initUI{
    
    self.view.backgroundColor = CLLineColor;
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"二手房源";
    
    
    [self.view addSubview:self.MainTableView];
}

#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _MainTableView.rowHeight = UITableViewAutomaticDimension;
        _MainTableView.estimatedRowHeight = 120 *SIZE;
        _MainTableView.backgroundColor = CLLineColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            
            _page = 1;
            [self RequestMethod];
        }];
        
        _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            
            [self RequestAddMethod];
        }];
    }
    return _MainTableView;
}



@end
