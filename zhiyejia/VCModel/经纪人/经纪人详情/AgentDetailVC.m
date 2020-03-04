//
//  AgentDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "AgentDetailVC.h"

#import "AgentDetailMoreRoomVC.h"
#import "AgentDetailMoreCommentVC.h"
#import "AgentRoomDetailVC.h"

#import "AgentDetailHeader.h"
#import "AgentDetailMoreBtnHeader.h"

#import "AgentRoomCell.h"
#import "AgentCommentCell.h"

#import "AgentDetailCommentView.h"

#import <WXApi.h>

@interface AgentDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_comment_id;
    NSString *_agent_id;
    
    NSMutableArray *_tagArr;
    NSMutableArray *_addressArr;;
    NSMutableArray *_headImgArr;;
    NSMutableArray *_roomArr;
    NSMutableArray *_commentArr;
    NSMutableArray *_configArr;
    
    NSMutableDictionary *_dataDic;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) AgentDetailCommentView *agentDetailCommentView;

@end

@implementation AgentDetailVC

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
    [self configRequest];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"goHome" object:nil];
    
    _dataDic = [@{} mutableCopy];
    
    _tagArr = [@[] mutableCopy];
    _addressArr = [@[] mutableCopy];
    _headImgArr = [@[] mutableCopy];
    _roomArr = [@[] mutableCopy];
    _commentArr = [@[] mutableCopy];
    _configArr = [@[] mutableCopy];
}

- (void)configRequest{
    
    [BaseRequest GET:GetAgentConfig_URL parameters:@{@"id":@"80"} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_configArr = [NSMutableArray arrayWithArray:resposeObject[@"80"][@"param"]];
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"agent_id":_agent_id}];
    if ([UserModel defaultModel].token) {
        
        [dic setValue:[UserModel defaultModel].agent_id forKey:@"home_agent_id"];
    }
    [BaseRequest GET:GetOnlineStoreInfo_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            self->_roomArr = [NSMutableArray arrayWithArray:self->_dataDic[@"recommend_house_list"]];
            self->_commentArr = [NSMutableArray arrayWithArray:self->_dataDic[@"comment_list"]];
            
            for (int i = 0; i < self->_commentArr.count; i++) {
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self->_commentArr[i]];
                [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                   
                    if ([obj isKindOfClass:[NSNull class]]) {
                        
                        if (![key isEqualToString:@"comment_tags"] && ![key isEqualToString:@"replyList"]) {
                            
                            [dic setValue:@"" forKey:key];
                        }else{
                            
                            [dic setValue:@[] forKey:key];
                        }
                    }
                }];
                
                [self->_commentArr replaceObjectAtIndex:i withObject:dic];
            }
            
            NSArray *arr;
            if ([self->_dataDic[@"self_tags"] length]) {
                
                arr = [self->_dataDic[@"self_tags"] componentsSeparatedByString:@","];
            }else{
                
                arr = @[];
            }
            self->_tagArr = [NSMutableArray arrayWithArray:arr];
            
            NSArray *arr1;
            if ([self->_dataDic[@"service_area"] length]) {
                
                arr1 = [self->_dataDic[@"service_area"] componentsSeparatedByString:@","];
            }else{
                
                arr1 = @[];
            }
            self->_addressArr = [NSMutableArray arrayWithArray:arr1];
            
            NSArray *arr2;
            if ([self->_dataDic[@"focus_info"][@"head_img_list"] count]) {
                
                arr2 = self->_dataDic[@"focus_info"][@"head_img_list"];
            }else{
                
                arr2 = @[];
            }
            self->_headImgArr = [NSMutableArray arrayWithArray:arr2];
            
            [self->_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }else if (section == 1){
        
        return _roomArr.count;
    }else{
        
        return _commentArr.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        AgentDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AgentDetailHeader"];
        if (!header) {
            
            header = [[AgentDetailHeader alloc] initWithReuseIdentifier:@"AgentDetailHeader"];
        }
        
        header.dataDic = _dataDic;
        header.dataArr = @[_tagArr,_addressArr,_headImgArr];
        
        header.agentDetailHeaderBlock = ^(NSInteger idx) {
          
            if (idx == 1) {
                
                NSString *phone = [NSString stringWithFormat:@"%@",self->_dataDic[@"tel"]];
                if (phone.length) {
                    
                    //获取目标号码字符串,转换成URL
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                    //调用系统方法拨号
                    [[UIApplication sharedApplication] openURL:url];
                }else{
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
                }
            }else if (idx == 2){
                
                if ([self->_dataDic[@"wx_code"] length]) {
                    
                    [self showContent:@"复制成功!"];
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    pasteboard.string = self->_dataDic[@"wx_code"];
                }
            }else if (idx == 3){
                
                WXMiniProgramObject *object = [WXMiniProgramObject object];
//                object.webpageUrl = webpageUrl;//网页链接
//                object.userName = @"gh_b5fe7a68ff6d";//小程序原始ID
//                object.path = path;//小程序对应的页面路径
//                object.hdImageData = hdImageData;//预览图二进制数据
//                object.withShareTicket = withShareTicket;//用于分享出去的小程序被二次打开的时候可以获取更多的信息
//                object.miniProgramType = programType;//对应小程序的类型，支持开发者区分开发版和体验版

                WXMediaMessage *message = [WXMediaMessage message];
                message.title = @"云算置业家";
                message.description = @"";
                message.thumbData = nil;  //兼容旧版本节点的图片，小于32KB，新版本优先
                                          //使用WXMiniProgramObject的hdImageData属性
                message.mediaObject = object;

                SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                req.bText = NO;
                req.message = message;
                req.scene = WXSceneSession;  //目前只支持会话
                [WXApi sendReq:req completion:^(BOOL success) {
                    
                }];
//                [WXApi sendReq:req];
                
            }else{
                
                if ([UserModel defaultModel].token.length) {
                
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"agent_id":self->_agent_id}];
                    if ([self->_dataDic[@"is_focus"] integerValue] == 1) {
                        
                        [dic setValue:@"0" forKey:@"is_focus"];
                    }else{
                        
                        [dic setValue:@"1" forKey:@"is_focus"];
                    }
                    
                    [BaseRequest POST:HomeFocusOperation_URL parameters:dic success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            if (self.agentDetailVCBlock) {
                                
                                NSString *str;
                                if ([self->_dataDic[@"is_focus"] integerValue] == 1) {
                                    
                                    str = @"0";
                                }else{
                                    
                                    str = @"1";
                                }
                                self.agentDetailVCBlock(str);
                            }
                            [self RequestMethod];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                }else{
                    
                    [self GotoLogin];
                }
            }
        };
        return header;
    }else{
        
        AgentDetailMoreBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AgentDetailMoreBtnHeader"];
        if (!header) {
            
            header = [[AgentDetailMoreBtnHeader alloc] initWithReuseIdentifier:@"AgentDetailMoreBtnHeader"];
        }
        
        if (section == 1) {
            
            header.titleL.text = @"推荐新房";
            header.moreBtn.hidden = NO;
            header.addBtn.hidden = YES;
            header.contentL.text = [NSString stringWithFormat:@"带看量：%@  成交量：%@",_dataDic[@""],_dataDic[@""]];
            [header.moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
            [header.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(header.contentView).offset(-10 *SIZE);
            }];
        }else{
            
            header.titleL.text = @"用户评价";
            header.moreBtn.hidden = NO;
            header.addBtn.hidden = NO;
            [header.moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
            [header.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(header.contentView).offset(-105 *SIZE);
            }];
        }
        
        header.agentDetailMoreBtnHeaderAddBlock = ^{
            
            if ([UserModel defaultModel].token.length) {
                
                if (self->_configArr.count) {
                    
                    self.agentDetailCommentView.tagArr = self->_configArr;;
                    self.agentDetailCommentView.nameL.text = [NSString stringWithFormat:@"经纪人姓名：%@",self->_dataDic[@"agent_name"]];
                    [self.view addSubview:self.agentDetailCommentView];
//                    AgentDetailCommentView *view = [[AgentDetailCommentView alloc] initWithFrame:self.view.bounds];
//                    view.tagArr = self->_configArr;
//                    view.nameL.text = [NSString stringWithFormat:@"经纪人姓名：%@",self->_dataDic[@"agent_name"]];
//                    view.agentDetailCommentViewBlock = ^(NSString * comment, NSString * score, NSString * tag) {
//
//                        if (comment.length) {
//
//                            [BaseRequest POST:AddAgentHomeComment_URL parameters:@{@"agent_id":self->_agent_id,@"grade":score,@"comment_tags":tag,@"comment":comment} success:^(id  _Nonnull resposeObject) {
//
//                                if ([resposeObject[@"code"] integerValue] == 200) {
//
//                                    [self RequestMethod];
//                                }else{
//
//                                    [self showContent:resposeObject[@"msg"]];
//                                }
//                            } failure:^(NSError * _Nonnull error) {
//
//                                [self showContent:@"网络错误"];
//                            }];
//                        }else{
//
//                            [self showContent:@"请输入评价内容"];
//                        }
//                    };
//                    [self.view addSubview:view];
                }else{
                    
                    [BaseRequest GET:GetAgentConfig_URL parameters:@{@"id":@"80"} success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            self->_configArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"80"][@"param"]];
                            
//                            AgentDetailCommentView *view = [[AgentDetailCommentView alloc] initWithFrame:self.view.bounds];
//                            view.tagArr = self->_configArr;
//                            view.nameL.text = [NSString stringWithFormat:@"经纪人姓名：%@",self->_dataDic[@"agent_name"]];
//                            view.agentDetailCommentViewBlock = ^(NSString * comment, NSString * score, NSString * tag) {
//
//                                if (comment.length) {
//
//                                    [BaseRequest POST:AddAgentHomeComment_URL parameters:@{@"agent_id":self->_agent_id,@"grade":score,@"comment_tags":tag,@"comment":comment} success:^(id  _Nonnull resposeObject) {
//
//                                        if ([resposeObject[@"code"] integerValue] == 200) {
//
//                                            [self RequestMethod];
//                                        }else{
//
//                                            [self showContent:resposeObject[@"msg"]];
//                                        }
//                                    } failure:^(NSError * _Nonnull error) {
//
//                                        [self showContent:@"网络错误"];
//                                    }];
//                                }else{
//
//                                    [self showContent:@"请输入评价内容"];
//                                }
//                            };
                            self.agentDetailCommentView.tagArr = self->_configArr;;
                            self.agentDetailCommentView.nameL.text = [NSString stringWithFormat:@"经纪人姓名：%@",self->_dataDic[@"agent_name"]];
                            [self.view addSubview:self.agentDetailCommentView];
//                            [self.view addSubview:view];
                        }else{
                            
                            
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        
                    }];
                }
            }else{
                
                [self GotoLogin];
            }
        };
        
        header.agentDetailMoreBtnHeaderMoreBlock = ^{
            
            if (section == 1) {
                
                AgentDetailMoreRoomVC *nextVC = [[AgentDetailMoreRoomVC alloc] initWithAgentId:self->_agent_id];
                nextVC.configArr = self->_configArr;
                nextVC.name = self->_dataDic[@"agent_name"];
                nextVC.agentDetailMoreRoomVCBlock = ^{
                    
                    [self RequestMethod];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                AgentDetailMoreCommentVC *nextVC = [[AgentDetailMoreCommentVC alloc] initWithAgentId:self->_agent_id];
                nextVC.configArr = self->_configArr;
                nextVC.name = self->_dataDic[@"agent_name"];
                nextVC.agentDetailMoreCommentVCBlock = ^{
                  
                    [self RequestMethod];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        };
        return header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        AgentRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentRoomCell"];
        if (!cell) {
            
            cell = [[AgentRoomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AgentRoomCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _roomArr[indexPath.row];
        
        return cell;
    }else{
        
        AgentCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCommentCell"];
        if (!cell) {
            
            cell = [[AgentCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AgentCommentCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _commentArr[indexPath.row];
        
        cell.agentCommentCellBlock = ^{
            
        };
        
        cell.agentCommentCellLabelBlock = ^{
            
        };
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
     
        AgentRoomDetailVC *nextVC = [[AgentRoomDetailVC alloc] initWithHouseId:[NSString stringWithFormat:@"%@",_roomArr[indexPath.row][@"house_id"]] info_id:@""];
        nextVC.projectName = [NSString stringWithFormat:@"%@",_roomArr[indexPath.row][@"project_name"]];
        nextVC.config_id = [NSString stringWithFormat:@"%@",_roomArr[indexPath.row][@"config_id"]];
        nextVC.configArr = self->_configArr;
        nextVC.agent_id = _agent_id;
        nextVC.name = self->_dataDic[@"agent_name"];
        nextVC.agentRoomDetailVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"经纪人详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _table.backgroundColor = CLWhiteColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
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
