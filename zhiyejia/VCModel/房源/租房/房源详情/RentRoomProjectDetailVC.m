//
//  RentRoomProjectDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RentRoomProjectDetailVC.h"

#import "NewRoomProjectDetailDetailVC.h"
#import "RentingComAllRoomListVC.h"

#import "RentRoomProjectHeader.h"
#import "TitleBaseHeader.h"
#import "NewRoomProjectDynamicCell.h"
#import "NewRoomProjectBuildingCell.h"
#import "NewRoomProjectAnalyzeCell.h"
#import "NewRoomProjectMapCell.h"
#import "SecRoomProjectAgentCell.h"
#import "SecRoomProjectPropertyTypeInfoCell.h"

@interface RentRoomProjectDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_projectId;
    NSString *_phone;
    NSString *_city;
    
    NSString *_latitude;
    NSString *_longitude;
    
    NSDictionary *_dataDic;
}

@property (nonatomic, strong) UITableView *roomTable;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UIImageView *attentImg;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIButton *counselBtn;

@end

@implementation RentRoomProjectDetailVC

- (instancetype)initWithProjectId:(NSString *)projectId city:(NSString *)city
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
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
    
}

- (void)RequestMethod{
    
    [BaseRequest GET:HomeRentProjectDetail_URL parameters:@{@"project_id":_projectId} success:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataDic = resposeObject[@"data"];
            self->_latitude = [NSString stringWithFormat:@"%@",self->_dataDic[@"project_basic_info"][@"latitude"]];
            self->_longitude = [NSString stringWithFormat:@"%@",self->_dataDic[@"project_basic_info"][@"longitude"]];
            if (self->_dataDic[@"butter_tel"]) {
                
                self->_phone = [NSString stringWithFormat:@"%@",self->_dataDic[@"butter_tel"]];
            }
            [self->_roomTable reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionAttentionBtn:(UIButton *)btn{
    
    
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        RentRoomProjectHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RentRoomProjectHeader"];
        if (!header) {
            
            header = [[RentRoomProjectHeader alloc] initWithReuseIdentifier:@"RentRoomProjectHeader"];
        }
        
        header.attentL.text = [NSString stringWithFormat:@"订阅人数：%@",_dataDic[@"focus"][@"num"]];
        [header setImgArr:_dataDic[@"project_img"][@"url"]];
        if (_dataDic[@"project_basic_info"]) {
            
            header.dataDic = _dataDic[@"project_basic_info"];
        }
        header.rentRoomProjectHeaderMoreBlock = ^{
            
            NewRoomProjectDetailDetailVC *nextVC = [[NewRoomProjectDetailDetailVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.rentRoomProjectHeaderTagBlock = ^(NSInteger btnNum) {
            
            if (btnNum == 1) {
                
                //
            }else if (btnNum == 2){
                
                //                SecDistributVC *nextVC = [[SecDistributVC alloc] init];
                //                nextVC.projiect_id = _projectId;
                //                nextVC.img_name = _model.total_float_url_phone;
                //                nextVC.status = @"release";
                //                nextVC.comName = _model.project_name;
                //                [self.navigationController pushViewController:nextVC animated:YES];
            }else if (btnNum == 3){
                
                RentingComAllRoomListVC *nextVC = [[RentingComAllRoomListVC alloc] initWithProjectId:self->_projectId city:self->_city];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                
                //                DealRecordVC *nextVC = [[DealRecordVC alloc] initWithProjectId:_projectId];
                //                [self.navigationController pushViewController:nextVC animated:YES];
                
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
    }
    return [[UIView alloc] initWithFrame:CGRectZero];
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
            
            cell.titleL.text = @"11111111";
            cell.contentL.text = @"222222222222222222222";
            cell.numL.text = @"共20条";
            cell.timeL.text = @"123123123123123";
            
            return cell;
            break;
        }
        case 2:{
            
            NewRoomProjectBuildingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomProjectBuildingCell"];
            if (!cell) {
                
                cell = [[NewRoomProjectBuildingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomProjectBuildingCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            break;
        }
        case 3:{
            
            SecRoomProjectPropertyTypeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecRoomProjectPropertyTypeInfoCell"];
            if (!cell) {
                
                cell = [[SecRoomProjectPropertyTypeInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecRoomProjectPropertyTypeInfoCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = @"物业类型信息";
            cell.houseL.text = @"住宅";
            cell.houseDetailL.text = @"在租：23套";
            cell.storeL.text = @"商铺";
            cell.storeDetailL.text = @"在租：23套";
            cell.buildL.text = @"写字楼";
            cell.buildDetailL.text = @"在租：23套";
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
            
            cell.dataDic = @{};
            
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

- (void)initUI{
    
    self.titleLabel.text = @"项目详情";
    
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 57 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
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
