//
//  AgentDetailMoreRoomVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "AgentDetailMoreRoomVC.h"

#import "AgentRoomDetailVC.h"

#import "AgentRoomCell.h"

@interface AgentDetailMoreRoomVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _page;

    NSString *_agent_id;
    
    NSMutableArray *_dataArr;

}

@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation AgentDetailMoreRoomVC

- (instancetype)initWithAgentId:(NSString *)agent_id
{
    self = [super init];
    if (self) {
        
        _agent_id = agent_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    if (_page == 1) {
        
        self.MainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page),@"agent_id":_agent_id}];
    
    [BaseRequest GET:GetRecommendHouseList_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            [self->_MainTableView reloadData];
            [self->_MainTableView.mj_header endRefreshing];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                
                [self SetData:resposeObject[@"data"][@"data"]];
                
            }else{
                
                [self->_dataArr removeAllObjects];
                self->_MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self->_MainTableView.mj_header endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self->_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page),@"agent_id":_agent_id}];
    
    [BaseRequest GET:GetRecommendHouseList_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self->_MainTableView.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"][@"data"]];
                
            }else{
                
                self->_MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            self->_page -= 1;
            [self->_MainTableView.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        self->_page -= 1;
        [self->_MainTableView.mj_footer endRefreshing];
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
    
    [self.MainTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AgentRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentRoomCell"];
    if (!cell) {
        
        cell = [[AgentRoomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AgentRoomCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AgentRoomDetailVC *nextVC = [[AgentRoomDetailVC alloc] initWithHouseId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"house_id"]] info_id:@""];
    nextVC.projectName = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"project_name"]];
    nextVC.config_id = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"config_id"]];
    nextVC.configArr = self->_configArr;
    nextVC.agent_id = _agent_id;
    nextVC.name = self.name;
    nextVC.agentRoomDetailVCBlock = ^{
        
        if (self.agentDetailMoreRoomVCBlock) {
            
            self.agentDetailMoreRoomVCBlock();
        }
        [self RequestMethod];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}
    
- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"新房推荐";
    
    _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360 *SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _MainTableView.backgroundColor = CLLineColor;
    _MainTableView.delegate = self;
    _MainTableView.dataSource = self;
    [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{

        self->_page = 1;
        [self RequestMethod];
    }];

    _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{

        self->_page += 1;
        [self RequestAddMethod];
    }];
    [self.view addSubview:_MainTableView];
}

@end
