//
//  RentRoomOfficeDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RentRoomOfficeDetailVC.h"

#import "RentRoomStoreDetailHeader.h"
#import "TitleRightBtnHeader.h"
#import "NewRoomProjectDetailFooter.h"
#import "RentRoomHouseInfoCell.h"
#import "SecRoomHouseDynamicCell.h"
#import "RentRoomStoreProjectCell.h"
#import "SecRoomHouseOtherHouseCell.h"

#import "RentRoomOfficeDetailModel.h"

@interface RentRoomOfficeDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_houseId;
    NSString *_city;
    
    RentRoomOfficeDetailModel *_model;
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

@implementation RentRoomOfficeDetailVC

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
    
    _imgArr = [@[] mutableCopy];
    _model = [[RentRoomOfficeDetailModel alloc] init];
    _focusDic = [@{} mutableCopy];
    _houseArr = [@[] mutableCopy];
    _takeInfoDic = [@{} mutableCopy];
}

- (void)RequestMethod{
    
    NSDictionary *dic = @{@"house_id":_houseId,
                          @"agent_id":@"21",
                          @"type":@(3)
                          };
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
        _model = [[RentRoomOfficeDetailModel alloc] initWithDictionary:tempDic];
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
            [_attentBtn setTitle:@"取消关注" forState:UIControlStateNormal];
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
        
        header.officeModel = _model;
        
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
            
            header.titleL.text = @"房源信息";
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
        
        RentRoomHouseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentRoomHouseInfoCell"];
        if (!cell) {
            
            cell = [[RentRoomHouseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentRoomHouseInfoCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = _model;
        return cell;
    }else if (indexPath.section == 2){
        
        SecRoomHouseDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecRoomHouseDynamicCell"];
        if (!cell) {
            
            cell = [[SecRoomHouseDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecRoomHouseDynamicCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
        
        cell.houseModel = _model;
        
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
                
                //                SecAllRoomDetailVC *nextVC = [[SecAllRoomDetailVC alloc] initWithHouseId:_houseArr[index][@"house_id"] city:_city];
                //                nextVC.type = [_houseArr[index][@"type"] integerValue];
                //                [self.navigationController pushViewController:nextVC animated:YES];
            }
        };
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 57 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    
    _roomTable.rowHeight = UITableViewAutomaticDimension;
    _roomTable.estimatedRowHeight = 200 *SIZE;
    
    _roomTable.estimatedSectionHeaderHeight = 316 *SIZE;
    
    _roomTable.backgroundColor = CLLineColor;
    _roomTable.delegate = self;
    _roomTable.dataSource = self;
    _roomTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_roomTable];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentBtn.frame = CGRectMake(0, self.view.frame.size.height - 50 *SIZE - TAB_BAR_MORE, 70 *SIZE, 43 *SIZE + TAB_BAR_MORE);
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
    _consultBtn.frame = CGRectMake(78 *SIZE, self.view.frame.size.height - 50 *SIZE - TAB_BAR_MORE, 133 *SIZE, 43 *SIZE + TAB_BAR_MORE);
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 *SIZE, 133 *SIZE, 13 *SIZE)];
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
