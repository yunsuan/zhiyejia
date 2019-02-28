//
//  SecRoomProjectDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomProjectDetailVC.h"

#import "NewRoomProjectDetailDetailVC.h"

#import "SecRoomProjectHeader.h"
#import "TitleBaseHeader.h"
#import "NewRoomProjectDynamicCell.h"
#import "NewRoomProjectBuildingCell.h"
//#import "NewRoomProjectHouseTypeCell.h"
#import "NewRoomProjectAnalyzeCell.h"
#import "SecRoomProjectPropertyTypeInfoCell.h"

@interface SecRoomProjectDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_projectId;
}

@property (nonatomic, strong) UITableView *roomTable;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UIImageView *attentImg;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIButton *counselBtn;

@end

@implementation SecRoomProjectDetailVC

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
    
//    [BaseRequest GET:HomeProjectDetail_URL parameters:@{@"project_id":_projectId} success:^(id  _Nonnull resposeObject) {
//
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
//        }else{
//
//
//        }
//    } failure:^(NSError * _Nonnull error) {
//
//        [self showContent:@"网络错误"];
//    }];
}

- (void)ActionAttentionBtn:(UIButton *)btn{
    
    
}

- (void)ActionCounselBtn:(UIButton *)btn{
    
    
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        SecRoomProjectHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SecRoomProjectHeader"];
        if (!header) {
            
            header = [[SecRoomProjectHeader alloc] initWithReuseIdentifier:@"SecRoomProjectHeader"];
        }
        
        [header setImgArr:@[]];
        header.secRoomProjectHeaderBlock = ^{
            
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
    
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 57 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
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
