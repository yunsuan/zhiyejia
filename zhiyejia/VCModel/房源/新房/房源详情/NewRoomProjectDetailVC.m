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

#import "NewRoomProjectHeader.h"
#import "TitleBaseHeader.h"
#import "NewRoomProjectDynamicCell.h"
#import "NewRoomProjectBuildingCell.h"
#import "NewRoomProjectHouseTypeCell.h"
#import "NewRoomProjectAnalyzeCell.h"

@interface NewRoomProjectDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_projectId;
    NSDictionary *_dataDic;
}

@property (nonatomic, strong) UITableView *roomTable;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIButton *counselBtn;

@property (nonatomic, strong) UIButton *appointBtn;
@end

@implementation NewRoomProjectDetailVC

- (instancetype)initWithProjectId:(NSString *)projectId
{
    self = [super init];
    if (self) {

        _projectId = projectId;
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
    
    [BaseRequest GET:HomeProjectDetail_URL parameters:@{@"project_id":_projectId} success:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataDic = resposeObject[@"data"];
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
    
    
}

- (void)ActionAppointionBtn:(UIButton *)btn{
    
    AppointSeeRoomVC *nextVC = [[AppointSeeRoomVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark -- tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }else if (section == 4){
        
        return 4;
    }
    return 1;
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
        header.dataDic = _dataDic[@"project_basic_info"];
        header.newRoomProjectHeaderMoreBlock = ^{
          
            NewRoomProjectDetailDetailVC *nextVC = [[NewRoomProjectDetailDetailVC alloc] init];
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
            
            if(_dataDic[@"project_basic_info"][@"total_float_url.length"] > 0){
                
                [cell.bigImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataDic[@"project_basic_info"][@"total_float_url.length"]]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
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

//                if (_houseArr.count) {
//                    HouseTypeDetailVC *nextVC = [[HouseTypeDetailVC alloc]initWithHouseTypeId:[NSString stringWithFormat:@"%@",_houseArr[index][@"id"]] index:index dataArr:_houseArr projectId:_projectId infoid:_info_id];
//
//                    nextVC.model = _model;
//                    [self.navigationController pushViewController:nextVC animated:YES];
//                }
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
            
            cell.titleL.text = @"项目优势";
            cell.contentL.text = @"房子二梯三户边套，南北通透户型，产证面积89平实用95平，可谈朝南带阳台，厨房朝北带很大生活阳台，一个卧室朝南，二个朝南。";
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
    
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _roomTable.sectionHeaderHeight = UITableViewAutomaticDimension;
    _roomTable.estimatedSectionHeaderHeight = 100 *SIZE;
    _roomTable.rowHeight = UITableViewAutomaticDimension;
    _roomTable.estimatedRowHeight = 360 *SIZE;
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
    [_attentBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_attentBtn setBackgroundColor:CLWhiteColor];
    [_attentBtn setTitleColor:CL86Color forState:UIControlStateNormal];
    [self.view addSubview:_attentBtn];
    
    _counselBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _counselBtn.frame = CGRectMake(87 *SIZE, self.view.frame.size.height - 47 *SIZE - TAB_BAR_MORE, 87 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _counselBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_counselBtn addTarget:self action:@selector(ActionCounselBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_counselBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [_counselBtn setBackgroundColor:COLOR(255, 188, 88, 1)];
    [_counselBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_counselBtn];
    
    _appointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _appointBtn.frame = CGRectMake(174 *SIZE, self.view.frame.size.height - 47 *SIZE - TAB_BAR_MORE, 186 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _appointBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_appointBtn addTarget:self action:@selector(ActionAppointionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_appointBtn setTitle:@"预约看房" forState:UIControlStateNormal];
    [_appointBtn setBackgroundColor:CLBlueBtnColor];
    [self.view addSubview:_appointBtn];
}
@end
