//
//  AgentRoomDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "AgentRoomDetailVC.h"

#import "BaseColorHeader.h"
#import "AgentRoomDetailHeader.h"

#import "AgentDetailCommentView.h"

#import "SingleContentCell.h"
#import "AgentRoomDetailCell.h"

#import "YBImageBrowser.h"

@interface AgentRoomDetailVC ()<UITableViewDelegate,UITableViewDataSource,YBImageBrowserDelegate>
{

    NSString *_house_id;
    NSString *_info_id;
    
    NSMutableDictionary *_dataDic;
    
    NSMutableArray *_imgArr;
}

@property (nonatomic, strong) UITableView *houseTable;

@property (nonatomic, strong) YBImageBrowser *browser;

@property (nonatomic, strong) UIButton *commentBtn;

@end

@implementation AgentRoomDetailVC

- (instancetype)initWithHouseId:(NSString *)house_id info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _info_id = info_id;
        _house_id = house_id;
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
    
    _dataDic = [@{} mutableCopy];
    _imgArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:GetHouseDetail_URL parameters:@{@"house_id":_house_id,@"config_id":self.config_id,@"agent_id":self.agent_id} success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {

            self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [self->_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

                if ([obj isKindOfClass:[NSNull class]]) {

                    [self->_dataDic setValue:@"" forKey:key];
                }
            }];

//            if ([self->_dataDic[@"recommend_house_info"][@"recommend_id"] integerValue] != 0) {
//
//                _content = [NSString stringWithFormat:@"%@",_dataDic[@"recommend_house_info"][@"comment"]];
//                _title = [NSString stringWithFormat:@"%@",_dataDic[@"recommend_house_info"][@"title"]];
//
//                self.cancelBtn.hidden = NO;
//                self.recommendBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, 240 *SIZE, 40 *SIZE + TAB_BAR_MORE);
//            }

            if ([self->_dataDic[@"imgInfo"][@"51"] count]) {

                [self->_imgArr addObject:@{@"type":@"户型图",@"list":self->_dataDic[@"imgInfo"][@"51"]}];
            }
            if ([self->_dataDic[@"imgInfo"][@"52"] count]) {

                [self->_imgArr addObject:@{@"type":@"3D图",@"list":self->_dataDic[@"imgInfo"][@"52"]}];
            }
            if ([self->_dataDic[@"imgInfo"][@"53"] count]) {

                [self->_imgArr addObject:@{@"type":@"效果图",@"list":self->_dataDic[@"imgInfo"][@"53"]}];
            }
            if ([self->_dataDic[@"imgInfo"][@"54"] count]) {

                [self->_imgArr addObject:@{@"type":@"平面图",@"list":self->_dataDic[@"imgInfo"][@"54"]}];
            }
            if ([self->_dataDic[@"imgInfo"][@"55"] count]) {

                [self->_imgArr addObject:@{@"type":@"实景图",@"list":self->_dataDic[@"imgInfo"][@"55"]}];
            }
            [self->_houseTable reloadData];
        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
    }];
}

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    if ([UserModel defaultModel].token.length) {
        
        if (self->_configArr.count) {
            
            AgentDetailCommentView *view = [[AgentDetailCommentView alloc] initWithFrame:self.view.bounds];
            view.tagArr = self->_configArr;
            view.nameL.text = [NSString stringWithFormat:@"经纪人姓名：%@",self.name];
            view.agentDetailCommentViewBlock = ^(NSString * comment, NSString * score, NSString * tag) {
                
                if (comment.length) {
                    
                    [BaseRequest POST:AddAgentHomeComment_URL parameters:@{@"agent_id":self->_agent_id,@"grade":score,@"comment_tags":tag,@"comment":comment,@"house_id":self->_house_id,@"config_id":self->_config_id} success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self showContent:@"评论成功"];
                            if (self.agentRoomDetailVCBlock) {
                                
                                self.agentRoomDetailVCBlock();
                            }
                            [self RequestMethod];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                }else{
                    
                    [self showContent:@"请输入评价内容"];
                }
            };
            [self.view addSubview:view];
        }else{
            
            [BaseRequest GET:GetAgentConfig_URL parameters:@{@"id":@"80"} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    self->_configArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"80"][@"param"]];
                    AgentDetailCommentView *view = [[AgentDetailCommentView alloc] initWithFrame:self.view.bounds];
                    view.tagArr = self->_configArr;
                    view.nameL.text = [NSString stringWithFormat:@"经纪人姓名：%@",self.name];
                    view.agentDetailCommentViewBlock = ^(NSString * comment, NSString * score, NSString * tag) {
                        
                        if (comment.length) {
                            
                            [BaseRequest POST:AddAgentHomeComment_URL parameters:@{@"agent_id":self->_agent_id,@"grade":score,@"comment_tags":tag,@"comment":comment,@"house_id":self->_house_id,@"config_id":self->_config_id} success:^(id  _Nonnull resposeObject) {
                                
                                if ([resposeObject[@"code"] integerValue] == 200) {
                                    
                                    [self showContent:@"评论成功"];
                                    if (self.agentRoomDetailVCBlock) {
                                        
                                        self.agentRoomDetailVCBlock();
                                    }
                                    [self RequestMethod];
                                }else{
                                    
                                    [self showContent:resposeObject[@"msg"]];
                                }
                            } failure:^(NSError * _Nonnull error) {
                                
                                [self showContent:@"网络错误"];
                            }];
                        }else{
                            
                            [self showContent:@"请输入评价内容"];
                        }
                    };
                    [self.view addSubview:view];
                }else{
                    
                    
                }
            } failure:^(NSError * _Nonnull error) {
                
                
            }];
        }
    }else{
        
        [self GotoLogin];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        AgentRoomDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AgentRoomDetailHeader"];
        if (!header) {
            
            header = [[AgentRoomDetailHeader alloc] initWithReuseIdentifier:@"AgentRoomDetailHeader"];
        }
        header.imgArr = [NSMutableArray arrayWithArray:_imgArr];
        header.agentRoomDetailHeaderImgBtnBlock = ^(NSInteger num, NSArray *imgArr) {
            
            NSMutableArray *tempArr = [NSMutableArray array];
            
            NSMutableArray *tempArr1 = [NSMutableArray array];
            for (NSDictionary *dic in imgArr) {
                
                for (NSDictionary *subDic in dic[@"list"]) {
                    
                    [tempArr1 addObject:subDic];
                }
            }
            [tempArr1 enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                YBImageBrowserModel *model = [YBImageBrowserModel new];
                model.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url"]]];
                if ([obj[@"img_url_3d"] length]) {
                    
                    model.third_URL = [NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url_3d"]];
                }
                
                [tempArr addObject:model];
            }];
            
            [self->_imgArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:obj];
                [tempDic setObject:obj[@"type"] forKey:@"name"];
                
                [tempDic setObject:obj[@"list"] forKey:@"data"];
                [self->_imgArr replaceObjectAtIndex:idx withObject:tempDic];
                
            }];
            
             YBImageBrowserModel *YBmodel = tempArr[num];
            if (YBmodel.third_URL.length) {
                
                BuildingAlbumVC *nextVC = [[BuildingAlbumVC alloc] init];
                nextVC.weburl = YBmodel.third_URL;
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
            YBImageBrowser *browser = [YBImageBrowser new];
            browser.delegate = self;
            browser.dataArray = tempArr;
            browser.albumArr = self->_imgArr;
            browser.infoid = self->_info_id;
            browser.currentIndex = num;
            [browser show];
            }
        };
        return header;
    }else{
        
        BaseColorHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseColorHeader"];
        if (!header) {
            
            header = [[BaseColorHeader alloc] initWithReuseIdentifier:@"BaseColorHeader"];
        }
        
        header.titleL.text = @"推荐理由";
        return header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = CLBackColor;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        AgentRoomDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentRoomDetailCell"];
        if (!cell) {
            
            cell = [[AgentRoomDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AgentRoomDetailCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _dataDic;
        return cell;
    }else{
        
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SingleContentCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentL.font = [UIFont systemFontOfSize:11 *SIZE];
        
        cell.contentL.text = _dataDic[@"sell_point"];
        return cell;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"房间详情";
    
    
    _houseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _houseTable.estimatedRowHeight = 150 *SIZE;
    _houseTable.rowHeight = UITableViewAutomaticDimension;
    _houseTable.backgroundColor = self.view.backgroundColor;
    _houseTable.delegate = self;
    _houseTable.dataSource = self;
    _houseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_houseTable];
    
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.frame = CGRectMake(0 *SIZE, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, 360 *SIZE, 40 *SIZE + TAB_BAR_MORE);
    [_commentBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_commentBtn setTitle:@"评论房间" forState:UIControlStateNormal];
    [_commentBtn setBackgroundColor:CLBlueBtnColor];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.view addSubview:_commentBtn];
}
@end
