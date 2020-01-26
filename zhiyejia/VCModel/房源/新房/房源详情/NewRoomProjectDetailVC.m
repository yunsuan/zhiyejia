//
//  NewRoomProjectDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewRoomProjectDetailVC.h"

#import "NewRoomProjectDetailDetailVC.h"
#import "AppointSeeRoomVC.h"
#import "DynamicListVC.h"
#import "DistributVC.h"
#import "DynamicDetailVC.h"
#import "NewRoomHouseDetailVC.h"
#import "NewRoomProjectAgentVC.h"
#import "EventDetailSignVC.h"
#import "EventListVC.h"

#import "NewRoomProjectHeader.h"
#import "NewRoomProjectDetailFooter.h"
#import "TitleBaseHeader.h"
#import "TitleRightBtnHeader.h"

#import "NewRoomDiscountCell.h"
#import "NewRoomProjectDynamicCell.h"
#import "NewRoomProjectBuildingCell.h"
#import "NewRoomProjectHouseTypeCell.h"
#import "NewRoomProjectAnalyzeCell.h"
#import "NewRoomProjectMapCell.h"
#import "NewRoomProjectAgentCell.h"
#import "NewRoomProjectResidentCell.h"

#import "NewRoomProjectAgentMoreView.h"



@interface NewRoomProjectDetailVC ()<UITableViewDelegate,UITableViewDataSource,YBImageBrowserDelegate>
{
    
    NewRoomModel *_model;
    NSString *_phone;
    NSString *_latitude;
    NSString *_longitude;
    
    NSDictionary *_dataDic;
    
    NSMutableDictionary *_focusDic;
    
    NSMutableArray *_imgArr;
    NSMutableArray *_albumArr;
}

@property (nonatomic, strong) UITableView *roomTable;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIButton *counselBtn;

@property (nonatomic, strong) UIButton *appointBtn;
@end

@implementation NewRoomProjectDetailVC

- (instancetype)initWithModel:(NewRoomModel *)model
{
    self = [super init];
    if (self) {

        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
    [self ImgRequest];
}

- (void)initDataSource{
    
    _focusDic = [@{} mutableCopy];
    _albumArr = [@[] mutableCopy];
    _imgArr = [@[] mutableCopy];
}

- (void)ImgRequest{
    
    [BaseRequest GET:GetImg_URL parameters:@{@"info_id":_model.info_id} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                
                [self SetImg:resposeObject[@"data"]];
            }else{
                
            }
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)SetImg:(NSArray *)data{
    
    [_albumArr removeAllObjects];
    for ( int i = 0; i < data.count; i++) {
        
        if ([data[i] isKindOfClass:[NSDictionary class]]) {
            
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
            
            [_albumArr addObject:tempDic];
        }
    }
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_model.project_id}];
    if ([UserModel defaultModel].token.length) {
        
        [dic setValue:[UserModel defaultModel].agent_id forKey:@"user_id"];
    }
    [BaseRequest GET:HomeProjectDetail_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataDic = resposeObject[@"data"];
            self->_focusDic = self->_dataDic[@"focus"];
            if ([self->_focusDic[@"is_focus"] integerValue]) {
                
                [self->_attentBtn setImage:IMAGE_WITH_NAME(@"Focus_selected") forState:UIControlStateNormal];
                [self->_attentBtn setTitle:@"取消订阅" forState:UIControlStateNormal];
            }else{
                
                [self->_attentBtn setImage:IMAGE_WITH_NAME(@"Focus") forState:UIControlStateNormal];
                [self->_attentBtn setTitle:@"订阅" forState:UIControlStateNormal];
            }
            if (self->_dataDic[@"butter_tel"]) {
                
                self->_phone = [NSString stringWithFormat:@"%@",self->_dataDic[@"butter_tel"]];
            }
            self->_latitude = [NSString stringWithFormat:@"%@",self->_dataDic[@"project_basic_info"][@"latitude"]];
            self->_longitude = [NSString stringWithFormat:@"%@",self->_dataDic[@"project_basic_info"][@"longitude"]];
            self->_imgArr = [[NSMutableArray alloc] initWithArray:self->_dataDic[@"project_img"][@"url"]];
            
            [self->_imgArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    if ([obj[@"img_url"] isKindOfClass:[NSNull class]]) {
                        
                        [self->_imgArr replaceObjectAtIndex:idx withObject:@{@"img_url":@""}];
                    }
                }else{
                    
                    [self->_imgArr replaceObjectAtIndex:idx withObject:@{@"img_url":@""}];
                }
            }];
            [self->_roomTable reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
       
        [self showContent:@"网络错误"];
    }];
}

- (void)PraiseRequest:(NSString *)rank_id is_awesome:(NSString *)is_awesome{
    
    NSDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"agent_id":rank_id}];
    if ([is_awesome integerValue] == 1) {
        
        [dic setValue:@"0" forKey:@"is_awesome"];
    }else{
        
        [dic setValue:@"1" forKey:@"is_awesome"];
    }
    
    [BaseRequest POST:GetAwesomeOperate_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
       
        [self showContent:@"网络错误"];
    }];
}


- (void)ActionAttentionBtn:(UIButton *)btn{
    
    if ([UserModel defaultModel].token.length) {
        
        if (_focusDic.count) {
            
            if ([_focusDic[@"is_focus"] integerValue] !=0) {
                
                [BaseRequest POST:CancelFocusProject_URL parameters:@{@"sub_id":_focusDic[@"is_focus"]} success:^(id resposeObject) {
                    
                    NSLog(@"%@",resposeObject);
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [self RequestMethod];
                    }
                    else{
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    NSLog(@"%@",error);
                    [self showContent:@"网络错误"];
                }];
            }else{
                
                [BaseRequest POST:PersonalFocusProject_URL parameters:@{@"project_id":_model.project_id,@"type":@"0"} success:^(id resposeObject) {
                    
                    NSLog(@"%@",resposeObject);
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [self RequestMethod];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                    [self RequestMethod];
                } failure:^(NSError *error) {
                    
                    NSLog(@"%@",error);
                    [self showContent:@"网络错误"];
                }];
            }
        }
    }else{
        
        [self GotoLogin];
    }
}

- (void)ActionCounselBtn:(UIButton *)btn{
    
    if (_phone.length) {
        
        //获取目标号码字符串,转换成URL
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_phone]];
        //调用系统方法拨号
        [[UIApplication sharedApplication] openURL:url];
    }else{
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
    }
}

- (void)ActionAppointionBtn:(UIButton *)btn{
    
    AppointSeeRoomVC *nextVC = [[AppointSeeRoomVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark -- tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        if ([_dataDic[@"project_active"] isKindOfClass:[NSArray class]] && [_dataDic[@"project_active"] count]) {
            
            return 1;
        }else{
            
            return 0;
        }
    }else if(section == 1){
     
        if ([_dataDic[@"project_dynamic"] isKindOfClass:[NSArray class]] && [_dataDic[@"project_dynamic"] count]) {
            
            return 1;
        }else{
            
            return 0;
        }
    }else if(section == 3){
        
        if ([_dataDic[@"house_type"] count]) {
            
            return 1;
        }else{
            
            return 0;
        }
    }else if (section == 4){
        
        return 4;
    }else if (section == 6){
        
        if ([_dataDic[@"agent_rank_list"] count]) {
            
            return 1;
        }
        return 0;
    }else if (section == 7){
        
        if ([_dataDic[@"resident_agent_list"] count]) {
            
            return [_dataDic[@"resident_agent_list"] count] > 3? 3:[_dataDic[@"resident_agent_list"] count];
        }
        return 0;
    }else{

        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        if ([_dataDic[@"dynamic"][@"first"] count]) {
            
            return UITableViewAutomaticDimension;
        }else{
            
            return CGFLOAT_MIN;
        }
    }else if (section == 3){
        
        if ([_dataDic[@"house_type"] count]) {
            
            return UITableViewAutomaticDimension;
        }else{
            
            return CGFLOAT_MIN;
        }
    }else if (section == 6){
        
        if ([_dataDic[@"agent_rank_list"] count]) {
            
            return UITableViewAutomaticDimension;
        }else{
            
            return CGFLOAT_MIN;
        }
    }else if (section == 7){
        
        if ([_dataDic[@"resident_agent_list"] count]) {
            
            return UITableViewAutomaticDimension;
        }else{
            
            return CGFLOAT_MIN;
        }
    }else{
        
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
     
        NewRoomProjectHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"NewRoomProjectHeader"];
        if (!header) {
            
            header = [[NewRoomProjectHeader alloc] initWithReuseIdentifier:@"NewRoomProjectHeader"];
        }
        
        [header setImgArr:_dataDic[@"project_img"][@"url"]];
        if (_dataDic[@"project_basic_info"]) {
            
            header.dataDic = _dataDic[@"project_basic_info"];
        }
        
        header.attentL.text = [NSString stringWithFormat:@"订阅人数：%@",_dataDic[@"focus"][@"num"]];
        
        header.newRoomProjectHeaderImgBtnBlock = ^(NSInteger num, NSArray *imgArr) {
            
            NSMutableArray *tempArr = [NSMutableArray array];
            [imgArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                YBImageBrowserModel *model = [YBImageBrowserModel new];
                model.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url"]]];
                [tempArr addObject:model];
            }];
            if (self->_albumArr.count) {

                YBImageBrowser *browser = [YBImageBrowser new];
                browser.delegate = self;
                browser.dataArray = tempArr;
                browser.albumArr = self->_albumArr;
                
                browser.infoid = self->_model.info_id;
                browser.currentIndex = num;
                [browser show];
            }else{
                
                [BaseRequest GET:GetImg_URL parameters:@{@"project_id":self->_model.project_id,@"info_id":self->_model.info_id} success:^(id resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                            
                            [self->_albumArr removeAllObjects];
                            for ( int i = 0; i < [resposeObject[@"data"] count]; i++) {
                                
                                if ([resposeObject[@"data"][i] isKindOfClass:[NSDictionary class]]) {
                                    
                                    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:resposeObject[@"data"][i]];
                                    
                                    [self->_albumArr addObject:tempDic];
                                    
                                    YBImageBrowser *browser = [YBImageBrowser new];
                                    browser.delegate = self;
                                    browser.albumArr = self->_albumArr;
                                    browser.dataArray = tempArr;
                                    browser.infoid = self->_model.info_id;
                                    browser.currentIndex = num;
                                    [browser show];
                                }
                            }
                        }else{
                            
                        }
                    }
                } failure:^(NSError *error) {
                    
                    NSLog(@"%@",error);
                }];
            }
        };
        
        header.newRoomProjectHeaderMoreBlock = ^{
          
            NewRoomProjectDetailDetailVC *nextVC = [[NewRoomProjectDetailDetailVC alloc] initWithinfoid:self->_model.info_id];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        return header;
    }else if (section == 4){
        
        TitleBaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleBaseHeader"];
        if (!header) {
            
            header = [[TitleBaseHeader alloc] initWithReuseIdentifier:@"TitleBaseHeader"];
        }
        header.titleL.text = @"项目分析";
        
        return header;
    }else if (section == 6){
        
        TitleRightBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleRightBtnHeader"];
        if (!header) {
            
            header = [[TitleRightBtnHeader alloc] initWithReuseIdentifier:@"TitleRightBtnHeader"];
        }
        header.titleL.text = @"金牌置业顾问";
        
        [header.moreBtn setTitle:@"更多置业顾问" forState:UIControlStateNormal];
        header.titleRightBtnHeaderMoreBlock = ^{
          
            NewRoomProjectAgentVC *nextVC = [[NewRoomProjectAgentVC alloc] initWithDataArr:self->_dataDic[@"agent_rank_list"]];
            nextVC.project_id = self->_model.project_id;
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return header;
    }else if (section == 7){
        
        TitleBaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleBaseHeader"];
        if (!header) {
            
            header = [[TitleBaseHeader alloc] initWithReuseIdentifier:@"TitleBaseHeader"];
        }
        header.titleL.text = @"项目驻场";
        
        return header;
    }else{
        
        NewRoomProjectDetailFooter *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"NewRoomProjectDetailFooter"];
        if (!header) {
            
            header = [[NewRoomProjectDetailFooter alloc] initWithReuseIdentifier:@"NewRoomProjectDetailFooter"];
        }
        
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.section) {
        case 0:
        {
            
            NewRoomDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomDiscountCell"];
            if (!cell) {
                
                cell = [[NewRoomDiscountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomDiscountCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.typeL.text = _dataDic[@"project_active"][@"active_tags"];
            cell.contentL.text = _dataDic[@"project_active"][@"active_name"];
            
            [cell.typeL mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(cell.typeL.mj_textWidth + 5 *SIZE);
            }];
            
            cell.newRoomDiscountCellBlock = ^{
              
                EventListVC *nextVC = [[EventListVC alloc] initWithinfoid:self->_model.project_id];
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            return cell;
            
            break;
        }
        case 1:{
            
            NewRoomProjectDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomProjectDynamicCell"];
            if (!cell) {
                
                cell = [[NewRoomProjectDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomProjectDynamicCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
//            cell.moreBtn.tag = indexPath.section;
            if (_dataDic[@"dynamic"]) {
                
                cell.numL.text = [NSString stringWithFormat: @"（共%@条）",_dataDic[@"dynamic"][@"count"]];
                cell.titleL.text = _dataDic[@"dynamic"][@"first"][@"title"];
                cell.timeL.text = _dataDic[@"dynamic"][@"first"][@"update_time"];
                cell.contentL.text = _dataDic[@"dynamic"][@"first"][@"abstract"];
            }
            
            cell.newRoomProjectDynamicCellBlock = ^{
              
                DynamicListVC *nextVC = [[DynamicListVC alloc] initWithinfoid:self->_model.info_id];
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            
            return cell;
            break;
        }
        case 2:{
            
            NewRoomProjectBuildingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomProjectBuildingCell"];
            if (!cell) {
                
                cell = [[NewRoomProjectBuildingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomProjectBuildingCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if([_dataDic[@"project_basic_info"][@"total_float_url"] length] > 0){
                
                [cell.bigImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataDic[@"project_basic_info"][@"total_float_url"]]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
                    if (error) {
                        
                        [UIImage imageNamed:@"banner_default_2"];
                    }
                }];
            }else{
                
                cell.bigImg.image = [UIImage imageNamed:@"banner_default_2"];
            }
            return cell;
            break;
        }
        case 3:{
            
            NewRoomProjectHouseTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomProjectHouseTypeCell"];
            if (!cell) {
                
                cell = [[NewRoomProjectHouseTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomProjectHouseTypeCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.num = [_dataDic[@"house_type"] count];
            if ([_dataDic[@"house_type"] count]) {

                cell.dataArr = [NSMutableArray arrayWithArray:_dataDic[@"house_type"]];
                [cell.cellColl reloadData];
            }else{

                [cell.cellColl reloadData];
            }

            cell.collCellBlock = ^(NSInteger index) {

                if ([self->_dataDic[@"house_type"] count]) {
                    NewRoomHouseDetailVC *nextVC = [[NewRoomHouseDetailVC alloc]initWithHouseTypeId:[NSString stringWithFormat:@"%@",self->_dataDic[@"house_type"][index][@"id"]] index:index dataArr:self->_dataDic[@"house_type"] projectId:self->_model.project_id infoid:@""];

//                    nextVC.model = _model;
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            };
            return cell;
            break;
        }
        case 4:{
            
            NewRoomProjectAnalyzeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomProjectAnalyzeCell"];
            if (!cell) {
                
                cell = [[NewRoomProjectAnalyzeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomProjectAnalyzeCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            switch (indexPath.row) {
                case 0:
                {
                    cell.titleL.text = @"项目优势";
                    if ([_dataDic[@"analyse"][@"advantage"] length]) {
                        
                        cell.contentL.text = _dataDic[@"analyse"][@"advantage"];
                    }else{
                        
                        cell.contentL.text = @"暂无数据";
                    }
                    break;
                }
                case 1:
                {
                    cell.titleL.text = @"周边分析";
                    if ([_dataDic[@"analyse"][@"rim"] length]) {
                        
                        cell.contentL.text = _dataDic[@"analyse"][@"rim"];
                    }else{
                        
                        cell.contentL.text = @"暂无数据";
                    }
                    break;
                }
                case 2:
                {
                    cell.titleL.text = @"升值空间";
                    if ([_dataDic[@"analyse"][@"increase_value"] length]) {
                        
                        cell.contentL.text = _dataDic[@"analyse"][@"increase_value"];
                    }else{
                        
                        cell.contentL.text = @"暂无数据";
                    }
                    break;
                }
                case 3:
                {
                    cell.titleL.text = @"适合人群";
                    if ([_dataDic[@"analyse"][@"fetch"] length]) {
                        
                        cell.contentL.text = _dataDic[@"analyse"][@"fetch"];
                    }else{
                        
                        cell.contentL.text = @"暂无数据";
                    }
                    break;
                }
                default:
                    break;
            }
            return cell;
            break;
        }
        case 5:{
            
            NewRoomProjectMapCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomProjectMapCell"];
            if (!cell) {
                
                cell = [[NewRoomProjectMapCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomProjectMapCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell SetLatitude:_latitude longitude:_longitude project:_dataDic[@"project_basic_info"][@"project_name"]];
            
            return cell;
            
            break;
        }case 6:{
            
            NewRoomProjectAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomProjectAgentCell"];
            if (!cell) {
                
                cell = [[NewRoomProjectAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomProjectAgentCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataArr = _dataDic[@"agent_rank_list"];
            
            cell.newRoomProjectAgentCellBlock = ^(NSInteger idx) {
              
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"agent_id":self->_dataDic[@"agent_rank_list"][idx][@"agent_id"]}];
                
                [BaseRequest GET:GetAgentRankDetail_URL parameters:dic success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        NewRoomProjectAgentMoreView *view = [[NewRoomProjectAgentMoreView alloc] initWithFrame:self.view.bounds];
                        view.dataDic = resposeObject[@"data"];
                        view.nameL.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"agent_rank_list"][idx][@"name"]];
                        view.newRoomProjectAgentMoreViewPraiseBlock = ^{
                            
                            if ([UserModel defaultModel].agent_id.length) {
                                
                                [self PraiseRequest:self->_dataDic[@"agent_rank_list"][idx][@"agent_id"] is_awesome:[NSString stringWithFormat:@"%@",self->_dataDic[@"agent_rank_list"][idx][@"is_awesome"]]];
                            }else{

                                [self GotoLogin];
                            }
                        };
                        view.newRoomProjectAgentMoreViewPhoneBlock = ^{
                          
                            if ([self->_dataDic[@"agent_rank_list"][idx][@"tel"] length]) {
                                
                                //获取目标号码字符串,转换成URL
                                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self->_dataDic[@"agent_rank_list"][idx][@"tel"]]];
                                //调用系统方法拨号
                                [[UIApplication sharedApplication] openURL:url];
                            }else{
                                
                                [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
                            }
                        };
                        [self.view addSubview:view];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                
                    [self showContent:@"获取信息失败"];
                }];
            };
            
            cell.newRoomProjectAgentCellPhoneBlock = ^(NSInteger idx) {
                
                if ([self->_dataDic[@"agent_rank_list"][idx][@"tel"] length]) {
                    
                    //获取目标号码字符串,转换成URL
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self->_dataDic[@"agent_rank_list"][idx][@"tel"]]];
                    //调用系统方法拨号
                    [[UIApplication sharedApplication] openURL:url];
                }else{
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
                }
            };
            return cell;
        }
        default:{
            
            NewRoomProjectResidentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomProjectResidentCell"];
            if (!cell) {
                
                cell = [[NewRoomProjectResidentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomProjectResidentCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataDic[@"resident_agent_list"][indexPath.row];
            cell.newRoomProjectResidentCellPhoneBlock = ^{
              
                if ([self->_dataDic[@"resident_agent_list"][indexPath.row][@"tel"] length]) {
                    
                    //获取目标号码字符串,转换成URL
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self->_dataDic[@"resident_agent_list"][indexPath.row][@"tel"]]];
                    //调用系统方法拨号
                    [[UIApplication sharedApplication] openURL:url];
                }else{
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
                }
            };
            return cell;
            break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        EventDetailSignVC *nextVC = [[EventDetailSignVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    if (indexPath.section == 2) {
        
        DistributVC *nextVC = [[DistributVC alloc] init];
        nextVC.urlfor3d = _model.total_float_url_panorama;
        nextVC.img_name = _model.total_float_url_phone;
        nextVC.projiect_id = _model.project_id;
        nextVC.titleStr = _model.project_name;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
    if (indexPath.section == 1) {
        
        DynamicDetailVC *nextVC = [[DynamicDetailVC alloc] initWithStr:_dataDic[@"dynamic"][@"first"][@"url"] titleStr:@"动态详情"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}


- (void)initUI{
    
    self.titleLabel.text = @"项目详情";
    
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _roomTable.rowHeight = UITableViewAutomaticDimension;
    _roomTable.estimatedRowHeight = 360 *SIZE;
    _roomTable.estimatedSectionHeaderHeight = 100 *SIZE;
    _roomTable.backgroundColor = self.view.backgroundColor;
    _roomTable.delegate = self;
    _roomTable.dataSource = self;
    _roomTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_roomTable];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentBtn.frame = CGRectMake(0, self.view.frame.size.height - 47 *SIZE - TAB_BAR_MORE, 87 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _attentBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_attentBtn addTarget:self action:@selector(ActionAttentionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_attentBtn setImage:IMAGE_WITH_NAME(@"Focus") forState:UIControlStateNormal];
    [_attentBtn setTitle:@"订阅" forState:UIControlStateNormal];
    [_attentBtn addTarget:self action:@selector(ActionAttentionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_attentBtn setBackgroundColor:CLWhiteColor];
    [_attentBtn setTitleColor:CL86Color forState:UIControlStateNormal];
    [self.view addSubview:_attentBtn];
    
    _counselBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _counselBtn.frame = CGRectMake(87 *SIZE, self.view.frame.size.height - 47 *SIZE - TAB_BAR_MORE, 273 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _counselBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_counselBtn addTarget:self action:@selector(ActionCounselBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_counselBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [_counselBtn setBackgroundColor:COLOR(255, 188, 88, 1)];
    [_counselBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_counselBtn];
    
//    _appointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _appointBtn.frame = CGRectMake(174 *SIZE, self.view.frame.size.height - 47 *SIZE - TAB_BAR_MORE, 186 *SIZE, 47 *SIZE + TAB_BAR_MORE);
//    _appointBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
//    [_appointBtn addTarget:self action:@selector(ActionAppointionBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_appointBtn setTitle:@"预约看房" forState:UIControlStateNormal];
//    [_appointBtn setBackgroundColor:CLBlueBtnColor];
//    [self.view addSubview:_appointBtn];
}
@end
