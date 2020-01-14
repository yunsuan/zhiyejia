//
//  SecRoomDealListVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecRoomDealListVC.h"

#import "SecRoomDealListCell.h"

@interface SecRoomDealListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _page;
    NSMutableArray *_dataArr;
    NSString *_city;
    NSString *_projectId;
}
@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation SecRoomDealListVC

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


- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    if (_city.length) {
        
        [dic setObject:_city forKey:@"city"];
    }
    [dic setObject:@"1" forKey:@"project_id"];
    [BaseRequest GET:ProjectGetHouseDealList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self.MainTableView.mj_header endRefreshing];
            [self->_dataArr removeAllObjects];
            [self SetData:resposeObject[@"data"][@"data"]];
            
        }else{
            
             [self.MainTableView.mj_header endRefreshing];
            [self showContent:resposeObject[@"msg"]];
           
        }
        [self->_MainTableView reloadData];
    } failure:^(NSError *error) {
        
        [self.MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)SetData:(NSArray *)data{
    
    if (data.count < 15) {

        self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{

        [self.MainTableView.mj_footer endRefreshing];
    }
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [_dataArr addObject:tempDic];
    }
    
    [self.MainTableView reloadData];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    if (_city.length) {
        
        [dic setObject:_city forKey:@"city"];
    }
    [dic setObject:_projectId forKey:@"project_id"];

    [BaseRequest GET:ProjectGetHouseDealList_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
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
    
    SecRoomDealListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecRoomDealListCell"];
    if (!cell) {

        cell = [[SecRoomDealListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecRoomDealListCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (void)initUI{
    
    self.view.backgroundColor = CLLineColor;
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"成交房源";
    
    
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
            
            self->_page = 1;
            [self RequestMethod];
        }];
        
        _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            
            [self RequestAddMethod];
        }];
    }
    return _MainTableView;
}
@end
