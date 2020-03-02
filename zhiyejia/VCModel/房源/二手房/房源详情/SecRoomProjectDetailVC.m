//
//  SecRoomProjectDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomProjectDetailVC.h"

#import "NewRoomProjectDetailDetailVC.h"
#import "SecComAllRoomListVC.h"
#import "SecRoomDealListVC.h"
#import "SecDistributVC.h"

#import "SecHouseBuyHouseDemandVC.h"
#import "SecHouseSaleHouseDemandVC.h"

#import "SecRoomProjectHeader.h"
#import "TitleBaseHeader.h"
#import "NewRoomProjectDetailFooter.h"
#import "NewRoomProjectDynamicCell.h"
#import "NewRoomProjectBuildingCell.h"
//#import "NewRoomProjectHouseTypeCell.h"
#import "NewRoomProjectAnalyzeCell.h"
#import "NewRoomProjectMapCell.h"
#import "SecRoomProjectAgentCell.h"
#import "SecRoomProjectPropertyTypeInfoCell.h"

#import "SinglePickView.h"

@interface SecRoomProjectDetailVC ()<UITableViewDelegate,UITableViewDataSource,YBImageBrowserDelegate>
{
    
    NSString *_projectId;
    NSString *_info_id;
    NSString *_phone;
    NSString *_city;
    
    NSString *_latitude;
    NSString *_longitude;
    
    SecProjectModel *_model;
    
    NSDictionary *_dataDic;
    
    NSMutableDictionary *_focusDic;
    
    NSMutableArray *_imgArr;
    NSMutableArray *_albumArr;
    NSMutableArray *_agentInfoArr;
}

@property (nonatomic, strong) UITableView *roomTable;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UIImageView *attentImg;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIButton *counselBtn;

@end

@implementation SecRoomProjectDetailVC

- (instancetype)initWithProjectId:(NSString *)project_id infoId:(NSString *)info_id city:(NSString *)city
{
    self = [super init];
    if (self) {
        
        _projectId = project_id;
        _info_id = info_id;
        _city = city;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"goHome" object:nil];
    _imgArr = [@[] mutableCopy];
    _albumArr = [@[] mutableCopy];
    _agentInfoArr = [@[] mutableCopy];
    
    _focusDic = [@{} mutableCopy];
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_projectId}];
    if ([UserModel defaultModel].token.length) {
        
        [dic setValue:[UserModel defaultModel].agent_id forKey:@"agent_id"];
    }
    [BaseRequest GET:HomeHouseProjectDetail_URL parameters:dic success:^(id  _Nonnull resposeObject) {

        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            self->_dataDic = resposeObject[@"data"];
            self->_focusDic = self->_dataDic[@"focus"];
            self->_latitude = [NSString stringWithFormat:@"%@",self->_dataDic[@"project_basic_info"][@"latitude"]];
            self->_longitude = [NSString stringWithFormat:@"%@",self->_dataDic[@"project_basic_info"][@"longitude"]];
            if ([self->_focusDic[@"is_focus"] integerValue]) {
                
                self->_attentImg.image = IMAGE_WITH_NAME(@"subscribe_click");
                self->_attentL.text = @"取消订阅";
            }else{
                
                self->_attentImg.image = IMAGE_WITH_NAME(@"subscribe");
                self->_attentL.text = @"订阅";
            }
            if (self->_dataDic[@"butter_tel"]) {
                
                self->_phone = [NSString stringWithFormat:@"%@",self->_dataDic[@"butter_tel"]];
            }
            if ([self->_dataDic[@"project_basic_info"] isKindOfClass:[NSDictionary class]]) {

                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self->_dataDic[@"project_basic_info"]];
                [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

                    if ([obj isKindOfClass:[NSNull class]]) {

                        if ([key isEqualToString:@"property_type"] || [key isEqualToString:@"project_tags"]) {
                            
                            [tempDic setObject:@[] forKey:key];
                        }else{
                        
                            [tempDic setObject:@"" forKey:key];
                        }
                    }
                }];
                self->_model = [[SecProjectModel alloc] initWithDictionary:tempDic];
            }
            _agentInfoArr = [NSMutableArray arrayWithArray:self->_dataDic[@"agent_info"]];
            if ([self->_dataDic[@"project_img"] isKindOfClass:[NSDictionary class]]) {

                if ([self->_dataDic[@"project_img"][@"url"] isKindOfClass:[NSArray class]]) {

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
                }
            }
            [self->_roomTable reloadData];
        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {

        [self showContent:@"网络错误"];
    }];
}

- (void)ImgRequest{
    
    [BaseRequest GET:GetImg_URL parameters:@{@"info_id":self->_info_id} success:^(id resposeObject) {

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
                
                [BaseRequest POST:PersonalFocusProject_URL parameters:@{@"project_id":_model.project_id,@"type":@"1"} success:^(id resposeObject) {
                    
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


#pragma mark -- tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }else if(section == 1){
        
        if ([_dataDic[@"dynamic"][@"first"] count]) {
            
            return 1;
        }else{
            
            return 0;
        }
    }else if (section == 4){
        
        return 4;
    }else if (section == 6){
        
        return _agentInfoArr.count > 3? 3:_agentInfoArr.count;;
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
        
        SecRoomProjectHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SecRoomProjectHeader"];
        if (!header) {
            
            header = [[SecRoomProjectHeader alloc] initWithReuseIdentifier:@"SecRoomProjectHeader"];
        }
        
        header.attentL.text = [NSString stringWithFormat:@"订阅人数：%@",_dataDic[@"focus"][@"num"]];
        header.imgArr = _imgArr;
        
        if (_dataDic[@"project_basic_info"]) {
            
            header.dataDic = _dataDic[@"project_basic_info"];
        }
        header.secRoomProjectHeaderMoreBlock = ^{
            
            NewRoomProjectDetailDetailVC *nextVC = [[NewRoomProjectDetailDetailVC alloc] initWithinfoid:self->_info_id];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.secRoomProjectHeaderImgBtnBlock = ^(NSInteger num, NSArray * _Nonnull imgArr) {
            
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
                browser.infoid = self->_info_id;
                browser.currentIndex = num;
                [browser show];
            }else{
                
                [BaseRequest GET:GetImg_URL parameters:@{@"info_id":self->_info_id} success:^(id resposeObject) {
                    
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
                                    browser.infoid  = self->_info_id;
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
        
        header.secRoomProjectHeaderTagBlock = ^(NSInteger btnNum) {
            
            if (btnNum == 1) {
                
                if ([UserModel defaultModel].token.length) {
                        
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[@{@"param":@"住宅",@"id":@"1"},@{@"param":@"商铺",@"id":@"2"},@{@"param":@"写字楼",@"id":@"3"}]];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        
                        NSString *type;
                        NSString *property;

                        type = @"1";
                        property = ID;

                        SecHouseBuyHouseDemandVC *nextVC = [[SecHouseBuyHouseDemandVC alloc] initWithType:type property:property];
                        nextVC.secHouseBuyHouseDemandVCBlock = ^{
                                                   
//                            [self RequestMethod];
                        };
                        [self.navigationController pushViewController:nextVC animated:YES];
                    };
                    [[UIApplication sharedApplication].keyWindow addSubview:view];
                }else{
                        
                    [self GotoLogin];
//                    [self RequestMethod];
                }
            }else if (btnNum == 2){
                
                if ([UserModel defaultModel].token.length) {
                        
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[@{@"param":@"住宅",@"id":@"1"},@{@"param":@"商铺",@"id":@"2"},@{@"param":@"写字楼",@"id":@"3"}]];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                            
                        NSString *type;
                        NSString *property;
                        
                        type = @"1";
                        property = ID;
                        
                        SecHouseSaleHouseDemandVC *nextVC = [[SecHouseSaleHouseDemandVC alloc] initWithType:type property:property];
                        nextVC.secHouseSaleHouseDemandVCBlock = ^{
                        
//                            [self RequestMethod];
                        };
                        [self.navigationController pushViewController:nextVC animated:YES];
                    };
                    [[UIApplication sharedApplication].keyWindow addSubview:view];
                }else{
                        
                    [self GotoLogin];
//                    [self RequestMethod];
                }
            }else if (btnNum == 3){
                
                SecComAllRoomListVC *nextVC = [[SecComAllRoomListVC alloc] initWithProjectId:self->_projectId city:self->_city];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                SecRoomDealListVC *nextVC = [[SecRoomDealListVC alloc] initWithProjectId:self->_projectId city:self->_city];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        };
        
        return header;
    }else if (section == 4){
        
        TitleBaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleBaseHeader"];
        if (!header) {
            
            header = [[TitleBaseHeader alloc] initWithReuseIdentifier:@"TitleBaseHeader"];
        }
        header.titleL.text = @"项目分析";
        
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
        case 1:{
            
            NewRoomProjectDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomProjectDynamicCell"];
            if (!cell) {
                
                cell = [[NewRoomProjectDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomProjectDynamicCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.moreBtn.tag = indexPath.section;
            if (_dataDic[@"dynamic"]) {
                
                cell.numL.text = [NSString stringWithFormat: @"（共%@条）",_dataDic[@"dynamic"][@"count"]];
                cell.titleL.text = _dataDic[@"dynamic"][@"first"][@"title"];
                cell.timeL.text = _dataDic[@"dynamic"][@"first"][@"update_time"];
                cell.contentL.text = _dataDic[@"dynamic"][@"first"][@"abstract"];
            }
            
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
            
            SecRoomProjectPropertyTypeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecRoomProjectPropertyTypeInfoCell"];
            if (!cell) {
                
                cell = [[SecRoomProjectPropertyTypeInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecRoomProjectPropertyTypeInfoCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataDic[@"property_count_list"];
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
        }
        case 6:{
            
            SecRoomProjectAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecRoomProjectAgentCell"];
            if (!cell) {
                
                cell = [[SecRoomProjectAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecRoomProjectAgentCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _agentInfoArr[indexPath.row];
            
            cell.secRoomProjectAgentCellWorkBlock = ^{
                
            };
            
            cell.secRoomProjectAgentCellPhoneBlock = ^{
                
                NSString *phone = [NSString stringWithFormat:@"%@",self->_agentInfoArr[indexPath.row][@"tel"]];
                if (phone.length) {
                    
                    //获取目标号码字符串,转换成URL
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                    //调用系统方法拨号
                    [[UIApplication sharedApplication] openURL:url];
                }else{
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
                }
            };
            return cell;
            break;
        }
        default:{
            
            NewRoomProjectDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomProjectDynamicCell"];
            if (!cell) {
                
                cell = [[NewRoomProjectDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomProjectDynamicCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = @"11111111";
            cell.contentL.text = @"222222222222222222222";
            cell.numL.text = @"共20条";
            cell.timeL.text = @"123123123123123";
            
            return cell;
            break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        
        SecDistributVC *nextVC = [[SecDistributVC alloc] init];
        nextVC.urlfor3d = _model.total_float_url_panorama;
        nextVC.projiect_id = _projectId;
        nextVC.img_name = _model.total_float_url_phone;
        nextVC.status = @"release";
        nextVC.comName = _model.project_name;
        [self.navigationController pushViewController:nextVC animated:YES];
        
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"项目详情";
    
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 57 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
//    _roomTable.sectionHeaderHeight = UITableViewAutomaticDimension;
    _roomTable.estimatedSectionHeaderHeight = 100 *SIZE;
    _roomTable.rowHeight = UITableViewAutomaticDimension;
    _roomTable.estimatedRowHeight = 360 *SIZE;
    _roomTable.backgroundColor = self.view.backgroundColor;
    _roomTable.delegate = self;
    _roomTable.dataSource = self;
    _roomTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_roomTable];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentBtn.frame = CGRectMake(0, self.view.frame.size.height - 50 *SIZE - TAB_BAR_MORE, 70 *SIZE, 57 *SIZE + TAB_BAR_MORE);
    _attentBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_attentBtn addTarget:self action:@selector(ActionAttentionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _attentImg = [[UIImageView alloc] initWithFrame:CGRectMake(27 *SIZE, 12 *SIZE, 16 *SIZE, 16 *SIZE)];
    _attentImg.image = IMAGE_WITH_NAME(@"subscribe");
    [_attentBtn addSubview:_attentImg];
    
    _attentL = [[UILabel alloc] initWithFrame:CGRectMake(0, 34 *SIZE, 70 *SIZE, 12 *SIZE)];
    _attentL.textColor = CL86Color;
    _attentL.text = @"订阅";
    _attentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _attentL.textAlignment = NSTextAlignmentCenter;;
    [_attentBtn addSubview:_attentL];
    
    [_attentBtn setBackgroundColor:CLWhiteColor];
    [_attentBtn setTitleColor:CL86Color forState:UIControlStateNormal];
    [self.view addSubview:_attentBtn];
    
    _counselBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _counselBtn.frame = CGRectMake(78 *SIZE, self.view.frame.size.height - 50 *SIZE - TAB_BAR_MORE, 273 *SIZE, 43 *SIZE + TAB_BAR_MORE);
    _counselBtn.layer.cornerRadius = 21.5 *SIZE + 17;
    _counselBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_counselBtn addTarget:self action:@selector(ActionCounselBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_counselBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [_counselBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
    gradientLayer0.cornerRadius = 21.666666666666668;
    gradientLayer0.frame = _counselBtn.bounds;
    gradientLayer0.colors = @[
                              (id)[UIColor colorWithRed:0.0f/255.0f green:132.0f/255.0f blue:244.0f/255.0f alpha:1.0f].CGColor,
                              (id)[UIColor colorWithRed:0.0f/255.0f green:172.0f/255.0f blue:240.0f/255.0f alpha:1.0f].CGColor];
    gradientLayer0.locations = @[@0, @1];
    [gradientLayer0 setStartPoint:CGPointMake(0, 1)];
    [gradientLayer0 setStartPoint:CGPointMake(0, 1)];
    [gradientLayer0 setEndPoint:CGPointMake(1, 0)];
    [_counselBtn.layer addSublayer:gradientLayer0];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 *SIZE, 273 *SIZE, 13 *SIZE)];
    label.textColor = CLWhiteColor;
    label.text = @"电话咨询";
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;;
    [_counselBtn addSubview:label];
    [self.view addSubview:_counselBtn];
    
}

@end
