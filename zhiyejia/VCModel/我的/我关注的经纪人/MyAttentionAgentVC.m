//
//  MyAttentionAgentVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MyAttentionAgentVC.h"

#import "AgentDetailVC.h"

#import "AgentCell.h"

@interface MyAttentionAgentVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _page;
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation MyAttentionAgentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initSource{
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:GetFocusList_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
        [self->_table reloadData];
    } failure:^(NSError * _Nonnull error) {
       
        [self->_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    self->_table.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:GetFocusList_URL parameters:@{@"page":@(_page)} success:^(id  _Nonnull resposeObject) {
        
        [self->_table.mj_footer endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
        [self->_table reloadData];
    } failure:^(NSError * _Nonnull error) {
        
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
            }else{
                
                [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    [_table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCell"];
    if (!cell) {
        
        cell = [[AgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AgentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.distanceL.hidden = YES;
    [cell.attentBtn setImage:IMAGE_WITH_NAME(@"Focus_selected") forState:UIControlStateNormal];
    
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
      
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"agent_id":self->_dataArr[indexPath.row][@"agent_id"]}];
        [dic setValue:@"0" forKey:@"is_focus"];
        
        [BaseRequest POST:HomeFocusOperation_URL parameters:dic success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self->_dataArr removeObjectAtIndex:indexPath.row];
                [self->_table reloadData];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AgentDetailVC *nextVC = [[AgentDetailVC alloc] initWithAgentId:[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"agent_id"]]];
    nextVC.agentDetailVCBlock = ^(NSString * str) {
      
        [self RequestMethod];
        [self->_table reloadData];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}



- (void)initUI{
    
    self.titleLabel.text = @"我的置业顾问";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        self->_page = 1;
        [self RequestMethod];
    }];
    
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        self->_page += 1;
        [self RequestAddMethod];
    }];
}

@end
