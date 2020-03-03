//
//  AgentDetailMoreCommentVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "AgentDetailMoreCommentVC.h"

#import "AgentDetailMoreBtnHeader.h"
#import "AgentCommentCell.h"

#import "AgentDetailCommentView.h"

@interface AgentDetailMoreCommentVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _idx;
    
    NSString *_comment_id;
    NSString *_agent_id;
    
    NSInteger _page;
    
    NSMutableArray *_dataArr;
}

@property (nonatomic , strong) UITableView *MainTableView;

@property (nonatomic, strong) AgentDetailCommentView *agentDetailCommentView;

@end

@implementation AgentDetailMoreCommentVC

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
    
    [BaseRequest GET:GetCommentList_URL parameters:dic success:^(id resposeObject) {
        
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
    
    [BaseRequest GET:GetCommentList_URL parameters:dic success:^(id resposeObject) {
        
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    AgentDetailMoreBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AgentDetailMoreBtnHeader"];
    if (!header) {
            
        header = [[AgentDetailMoreBtnHeader alloc] initWithReuseIdentifier:@"AgentDetailMoreBtnHeader"];
    }
        
    header.titleL.text = @"用户评价";
    header.moreBtn.hidden = YES;
    header.addBtn.hidden = NO;
    [header.moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    [header.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(header.contentView).offset(-105 *SIZE);
    }];
        
    header.agentDetailMoreBtnHeaderAddBlock = ^{
            
        if ([UserModel defaultModel].token.length) {
            
            if (self->_configArr.count) {
                
//                AgentDetailCommentView *view = [[AgentDetailCommentView alloc] initWithFrame:self.view.bounds];
//                view.tagArr = self->_configArr;
//                view.nameL.text = [NSString stringWithFormat:@"经纪人姓名：%@",self.name];
//                view.agentDetailCommentViewBlock = ^(NSString * comment, NSString * score, NSString * tag) {
//
//                    if (comment.length) {
//
//                        [BaseRequest POST:AddAgentHomeComment_URL parameters:@{@"agent_id":self->_agent_id,@"grade":score,@"comment_tags":tag,@"comment":comment} success:^(id  _Nonnull resposeObject) {
//
//                            if ([resposeObject[@"code"] integerValue] == 200) {
//
//                                if (self.agentDetailMoreCommentVCBlock) {
//
//                                    self.agentDetailMoreCommentVCBlock();
//                                }
//                                [self RequestMethod];
//                            }else{
//
//                                [self showContent:resposeObject[@"msg"]];
//                            }
//                        } failure:^(NSError * _Nonnull error) {
//
//                            [self showContent:@"网络错误"];
//                        }];
//                    }else{
//
//                        [self showContent:@"请输入评价内容"];
//                    }
//                };
//                [self.view addSubview:view];
                self.agentDetailCommentView.tagArr = self->_configArr;;
                self.agentDetailCommentView.nameL.text = [NSString stringWithFormat:@"经纪人姓名：%@",self.name];
                [self.view addSubview:self.agentDetailCommentView];
            }else{
                
                [BaseRequest GET:GetAgentConfig_URL parameters:@{@"id":@"80"} success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        self->_configArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"80"][@"param"]];
                        self.agentDetailCommentView.tagArr = self->_configArr;;
                        self.agentDetailCommentView.nameL.text = [NSString stringWithFormat:@"经纪人姓名：%@",self.name];
                        [self.view addSubview:self.agentDetailCommentView];
//                        AgentDetailCommentView *view = [[AgentDetailCommentView alloc] initWithFrame:self.view.bounds];
//                        view.tagArr = self->_configArr;
//                        view.nameL.text = [NSString stringWithFormat:@"经纪人姓名：%@",self.name];
//                        view.agentDetailCommentViewBlock = ^(NSString * comment, NSString * score, NSString * tag) {
//
//                            if (comment.length) {
//
//                                [BaseRequest POST:AddAgentHomeComment_URL parameters:@{@"agent_id":self->_agent_id,@"grade":score,@"comment_tags":tag,@"comment":comment} success:^(id  _Nonnull resposeObject) {
//
//                                    if ([resposeObject[@"code"] integerValue] == 200) {
//
//                                        if (self.agentDetailMoreCommentVCBlock) {
//
//                                            self.agentDetailMoreCommentVCBlock();
//                                        }
//                                        [self RequestMethod];
//                                    }else{
//
//                                        [self showContent:resposeObject[@"msg"]];
//                                    }
//                                } failure:^(NSError * _Nonnull error) {
//
//                                    [self showContent:@"网络错误"];
//                                }];
//                            }else{
//
//                                [self showContent:@"请输入评价内容"];
//                            }
//                        };
//                        [self.view addSubview:view];
                    }else{
                        
                        
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                    
                }];
            }
        }else{
            
            [self GotoLogin];
        }
    };
        
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AgentCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCommentCell"];
    if (!cell) {
        
        cell = [[AgentCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AgentCommentCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

    
- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客户评论";
    
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

- (AgentDetailCommentView *)agentDetailCommentView{
    
    if (!_agentDetailCommentView) {
        
        _agentDetailCommentView = [[AgentDetailCommentView alloc] initWithFrame:self.view.bounds];
        SS(strongSelf);
        _agentDetailCommentView.agentDetailCommentViewBlock = ^(NSString * comment, NSString * score, NSString * tag) {
            
            strongSelf->_agentDetailCommentView.commentTV.text = @"";
            if (comment.length) {
                
                [BaseRequest POST:AddAgentHomeComment_URL parameters:@{@"agent_id":strongSelf->_agent_id,@"grade":score,@"comment_tags":tag,@"comment":comment} success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [strongSelf RequestMethod];
                    }else{
                        
                        [strongSelf showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                    [strongSelf showContent:@"网络错误"];
                }];
            }else{
                
                [strongSelf showContent:@"请输入评价内容"];
            }
        };
    }
    return _agentDetailCommentView;
}

@end
