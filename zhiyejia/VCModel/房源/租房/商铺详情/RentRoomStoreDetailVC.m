//
//  RentRoomStoreDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RentRoomStoreDetailVC.h"

#import "RentRoomOfficeDetailVC.h"
#import "RentRoomHouseDetailVC.h"

#import "RentRoomProjectDetailVC.h"

#import "RentRoomStoreDetailHeader.h"
#import "TitleRightBtnHeader.h"
#import "NewRoomProjectDetailFooter.h"
#import "RentRoomStoreInfoCell.h"
#import "SecRoomHouseDynamicCell.h"
#import "RentRoomStoreProjectCell.h"
#import "SecRoomHouseOtherHouseCell.h"

#import "SecRoomHouseDetailModel.h"
#import "SecRoomMapCell.h"

@interface RentRoomStoreDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_houseId;
    NSString *_city;
    
    RentRoomStoreDetailModel *_model;
    NSString *_phone;
    NSMutableArray *_imgArr;
    NSMutableDictionary *_focusDic;
    NSString *_focusId;
    NSMutableArray *_houseArr;
    NSMutableDictionary *_takeInfoDic;
}
@property (nonatomic, strong) UITableView *roomTable;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UIImageView *attentImg;

@property (nonatomic, strong) UIButton *consultBtn;

@property (nonatomic, strong) UIButton *appointBtn;

@end

@implementation RentRoomStoreDetailVC

- (instancetype)initWithHouseId:(NSString *)houseId city:(NSString *)city
{
    self = [super init];
    if (self) {
        
        _houseId = houseId;
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
//    _model = [[SecRoomHouseDetailModel alloc] init];
    _focusDic = [@{} mutableCopy];
    _houseArr = [@[] mutableCopy];
    _takeInfoDic = [@{} mutableCopy];
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"house_id":_houseId,@"type":@"2"}];
    if ([UserModel defaultModel].token.length) {
        
        [dic setValue:[UserModel defaultModel].agent_id forKey:@"agent_id"];
    }
    [BaseRequest GET:RentHouseDetail_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    _phone = [NSString stringWithFormat:@"%@",data[@"agent_info"]];
    
    if ([data[@"basic_info"] isKindOfClass:[NSDictionary class]]) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[@"basic_info"]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }else{
                
                if ([obj isKindOfClass:[NSNumber class]]) {
                    
                    [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }
            }
        }];
        _model = [[RentRoomStoreDetailModel alloc] initWithDictionary:tempDic];
    }
    
    [_imgArr removeAllObjects];
    if ([data[@"img"] isKindOfClass:[NSArray class]]) {
        
        NSArray *arr = data[@"img"];
        for ( int i = 0; i < arr.count; i++) {
            
            if ([arr[i] isKindOfClass:[NSDictionary class]]) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:arr[i]];
                
                [_imgArr addObject:tempDic];
            }
        }
    }
    
    if ([data[@"focus"] isKindOfClass:[NSDictionary class]]) {
        
        if ([data[@"focus"][@"is_focus"] integerValue]) {
            
            _focusId = [NSString stringWithFormat:@"%@",data[@"focus"][@"is_focus"]];
            _attentL.text = @"取消关注";
        }
        _focusDic = [NSMutableDictionary dictionaryWithDictionary:data[@"focus"]];
    }
    _attentBtn.userInteractionEnabled = YES;
    
    if ([data[@"other"] isKindOfClass:[NSArray class]]) {
        
        _houseArr = [NSMutableArray arrayWithArray:data[@"other"]];
    }
    
    if ([data[@"take_info"] isKindOfClass:[NSDictionary class]]) {
        
        _takeInfoDic = [NSMutableDictionary dictionaryWithDictionary:data[@"take_info"]];
    }
    
    [_roomTable reloadData];
}

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    
}

- (void)ActionAttentBtn:(UIButton *)btn{
    
    if ([UserModel defaultModel].token) {
        
        if (!_focusId.length) {
            
            [BaseRequest GET:PersonalFocusHouse_URL parameters:@{@"house_id":_houseId,@"type":@"2"} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    self->_attentL.text = @"取消关注";
                    self->_focusId = [NSString stringWithFormat:@"%@",resposeObject[@"data"]];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [self showContent:@"网络错误"];
            }];
        }else{
            
            [BaseRequest GET:PersonalCancelFocusHouse_URL parameters:@{@"focus_id":_focusId} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    self->_attentL.text = @"关注";
                    self->_focusId = @"";
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [self showContent:@"网络错误"];
            }];
        }
    }else{
        
        [self GotoLogin];
    }
}

- (void)ActionConsultBtn:(UIButton *)btn{
    
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
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 4 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        RentRoomStoreDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RentRoomStoreDetailHeader"];
        if (!header) {
            
            header = [[RentRoomStoreDetailHeader alloc] initWithReuseIdentifier:@"RentRoomStoreDetailHeader"];
        }
        
        header.imgArr = [NSMutableArray arrayWithArray:_imgArr];
        
        header.storeModel = _model;
        
        return header;
    }else{
        
        TitleRightBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleRightBtnHeader"];
        if (!header) {
            
            header = [[TitleRightBtnHeader alloc] initWithReuseIdentifier:@"TitleRightBtnHeader"];
        }
        
        header.moreBtn.hidden = YES;
        if (section == 1) {
            
            header.titleL.text = @"房源信息";
        }else if (section == 2){
            
            header.titleL.text = @"周边及配套 ";
        }else if (section == 3){
            
            header.titleL.text = @"房源动态";
        }else if (section == 4){
            
//            header.titleL.text = @"房源信息";
            header.titleL.text = _model.title;
            header.moreBtn.hidden = NO;
            header.titleRightBtnHeaderMoreBlock = ^{
              
                RentRoomProjectDetailVC *nextVC = [[RentRoomProjectDetailVC alloc] initWithProjectId:self->_model.project_id infoId:self->_model.info_id city:self->_city];
                [self.navigationController pushViewController:nextVC animated:YES];
            };
        }else{
            
            header.titleL.text = @"小区其他房源";
        }
        
        return header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    NewRoomProjectDetailFooter *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"NewRoomProjectDetailFooter"];
    if (!header) {
        
        header = [[NewRoomProjectDetailFooter alloc] initWithReuseIdentifier:@"NewRoomProjectDetailFooter"];
    }
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        RentRoomStoreInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentRoomStoreInfoCell"];
        if (!cell) {
            
            cell = [[RentRoomStoreInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentRoomStoreInfoCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.storeModel = _model;
        return cell;
    }else if (indexPath.section == 2){
        
        SecRoomMapCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecRoomMapCell"];
        if (!cell) {
            
            cell = [[SecRoomMapCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecRoomMapCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell SetLatitude:_model.latitude longitude:_model.longitude project:_model.project_name];
        
        return cell;
    }else if (indexPath.section == 3){
        
        SecRoomHouseDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecRoomHouseDynamicCell"];
        if (!cell) {
            
            cell = [[SecRoomHouseDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecRoomHouseDynamicCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _takeInfoDic;
        return cell;
    }else if (indexPath.section == 4){
        
        RentRoomStoreProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentRoomStoreProjectCell"];
        if (!cell) {
            
            cell = [[RentRoomStoreProjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentRoomStoreProjectCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.storeModel = _model;
        return cell;
    }else{
        
        SecRoomHouseOtherHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecRoomHouseOtherHouseCell"];
        if (!cell) {
            
            cell = [[SecRoomHouseOtherHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecRoomHouseOtherHouseCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (_houseArr.count) {
            
            cell.num = _houseArr.count;
        }else{
            
            cell.num = 1;
        }
        
        if (_houseArr.count) {
            
            cell.dataArr = [NSMutableArray arrayWithArray:_houseArr];
            [cell.cellColl reloadData];
        }else{
            
            [cell.cellColl reloadData];
        }
        
        cell.secRoomHouseOtherHouseCellBlock = ^(NSInteger index) {
            
            if (self->_houseArr.count) {
                
                if ([self->_houseArr[index][@"type"] integerValue] == 1) {
                    
                    RentRoomHouseDetailVC *nextVC = [[RentRoomHouseDetailVC alloc] initWithHouseId:self->_houseArr[index][@"house_id"] city:self->_city];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }else if ([self->_houseArr[index][@"type"] integerValue] == 2){
                    
                    RentRoomStoreDetailVC *nextVC = [[RentRoomStoreDetailVC alloc] initWithHouseId:self->_houseArr[index][@"house_id"] city:self->_city];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }else{
                    
                    RentRoomOfficeDetailVC *nextVC = [[RentRoomOfficeDetailVC alloc] initWithHouseId:self->_houseArr[index][@"house_id"] city:self->_city];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            }
        };
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - 57 *SIZE - TAB_BAR_MORE - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    
    _roomTable.rowHeight = UITableViewAutomaticDimension;
    _roomTable.estimatedRowHeight = 200 *SIZE;
    
    _roomTable.estimatedSectionHeaderHeight = 316 *SIZE;
    
    _roomTable.backgroundColor = CLLineColor;
    _roomTable.delegate = self;
    _roomTable.dataSource = self;
    _roomTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_roomTable];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentBtn.frame = CGRectMake(0, self.view.frame.size.height - 50 *SIZE - TAB_BAR_MORE - NAVIGATION_BAR_HEIGHT, 70 *SIZE, 43 *SIZE + TAB_BAR_MORE);
    _attentBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_attentBtn addTarget:self action:@selector(ActionAttentBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _attentImg = [[UIImageView alloc] initWithFrame:CGRectMake(27 *SIZE, 12 *SIZE, 16 *SIZE, 16 *SIZE)];
    _attentImg.image = IMAGE_WITH_NAME(@"subscribe");
    [_attentBtn addSubview:_attentImg];
    
    _attentL = [[UILabel alloc] initWithFrame:CGRectMake(0, 34 *SIZE, 70 *SIZE, 12 *SIZE)];
    _attentL.textColor = CL86Color;
    _attentL.text = @"关注";
    _attentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _attentL.textAlignment = NSTextAlignmentCenter;;
    [_attentBtn addSubview:_attentL];
    
    [_attentBtn setBackgroundColor:CLWhiteColor];
    [_attentBtn setTitleColor:CL86Color forState:UIControlStateNormal];
    [self.view addSubview:_attentBtn];
    
    _consultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _consultBtn.frame = CGRectMake(78 *SIZE, self.view.frame.size.height - 50 *SIZE - TAB_BAR_MORE - NAVIGATION_BAR_HEIGHT, 273 *SIZE, 43 *SIZE + TAB_BAR_MORE);
    _consultBtn.layer.cornerRadius = 7 *SIZE;//21.5 *SIZE + 17;
    _consultBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_consultBtn addTarget:self action:@selector(ActionConsultBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [_counselBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [_consultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
    gradientLayer0.cornerRadius = 7 *SIZE;
    gradientLayer0.frame = _consultBtn.bounds;
    gradientLayer0.colors = @[
                              (id)[UIColor colorWithRed:247.0f/255.0f green:198.0f/255.0f blue:53.0f/255.0f alpha:1.0f].CGColor,
                              (id)[UIColor colorWithRed:255.0f/255.0f green:205.0f/255.0f blue:64.0f/255.0f alpha:1.0f].CGColor];
    gradientLayer0.locations = @[@0, @1];
    //    [gradientLayer0 setStartPoint:CGPointMake(0, 1)];
    [gradientLayer0 setStartPoint:CGPointMake(0, 1)];
    [gradientLayer0 setEndPoint:CGPointMake(1, 0)];
    [_consultBtn.layer addSublayer:gradientLayer0];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 *SIZE, 273 *SIZE, 13 *SIZE)];
    label.textColor = CLWhiteColor;
    label.text = @"电话咨询";
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;;
    [_consultBtn addSubview:label];
    [self.view addSubview:_consultBtn];
    
    
    _appointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _appointBtn.frame = CGRectMake(217 *SIZE, self.view.frame.size.height - 50 *SIZE - TAB_BAR_MORE, 133 *SIZE, 43 *SIZE + TAB_BAR_MORE);
    _appointBtn.layer.cornerRadius = 7 *SIZE;//21.5 *SIZE + 17;
    _appointBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_appointBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [_counselBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [_appointBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CAGradientLayer *gradientLayer1 = [[CAGradientLayer alloc] init];
    gradientLayer1.cornerRadius = 7 *SIZE;
    gradientLayer1.frame = _appointBtn.bounds;
    gradientLayer1.colors = @[
                              (id)[UIColor colorWithRed:0.0f/255.0f green:132.0f/255.0f blue:244.0f/255.0f alpha:1.0f].CGColor,
                              (id)[UIColor colorWithRed:0.0f/255.0f green:170.0f/255.0f blue:238.0f/255.0f alpha:1.0f].CGColor];
    gradientLayer1.locations = @[@0, @1];
    [gradientLayer1 setStartPoint:CGPointMake(0, 1)];
    [gradientLayer1 setEndPoint:CGPointMake(1, 0)];
    [_appointBtn.layer addSublayer:gradientLayer1];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 *SIZE, 133 *SIZE, 13 *SIZE)];
    label1.textColor = CLWhiteColor;
    label1.text = @"预约看房";
    label1.font = [UIFont systemFontOfSize:13 *SIZE];
    label1.textAlignment = NSTextAlignmentCenter;;
    [_appointBtn addSubview:label1];
    [self.view addSubview:_appointBtn];
}

@end
