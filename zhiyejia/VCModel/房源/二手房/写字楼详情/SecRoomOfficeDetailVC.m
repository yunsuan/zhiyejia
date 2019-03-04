//
//  SecRoomOfficeDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomOfficeDetailVC.h"

#import "SecRoomHouseDetailHeader.h"
#import "SecRoomOfficeInfoCell.h"
#import "SecRoomHouseProjectCell.h"
#import "SecRoomHouseOtherHouseCell.h"

@interface SecRoomOfficeDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *roomTable;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UIImageView *attentImg;

@property (nonatomic, strong) UIButton *consultBtn;

@property (nonatomic, strong) UIButton *appointBtn;

@end

@implementation SecRoomOfficeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
    
}

- (void)initDataSource{
    
    //    _imgArr = [@[] mutableCopy];
    //    _model = [[SecAllRoomProjectModel alloc] init];
    //    _focusDic = [@{} mutableCopy];
    //    _houseArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
}

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    
}

- (void)ActionAttentBtn:(UIButton *)btn{
    
    
}

- (void)ActionConsultBtn:(UIButton *)btn{
    
    
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
    
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    SecRoomHouseDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SecRoomHouseDetailHeader"];
    if (!header) {
        
        header = [[SecRoomHouseDetailHeader alloc] initWithReuseIdentifier:@"SecRoomHouseDetailHeader"];
    }
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecRoomOfficeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecRoomOfficeInfoCell"];
    if (!cell) {
        
        cell = [[SecRoomOfficeInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecRoomOfficeInfoCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    
    _roomTable.rowHeight = UITableViewAutomaticDimension;
    _roomTable.estimatedRowHeight = 200 *SIZE;
    
    _roomTable.estimatedSectionHeaderHeight = 316 *SIZE;
    
    _roomTable.backgroundColor = self.view.backgroundColor;
    _roomTable.delegate = self;
    _roomTable.dataSource = self;
    _roomTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_roomTable];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentBtn.frame = CGRectMake(0, self.view.frame.size.height - 50 *SIZE - TAB_BAR_MORE, 70 *SIZE, 57 *SIZE + TAB_BAR_MORE);
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
    _consultBtn.layer.cornerRadius = 21.5 *SIZE + 17;
    _consultBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_consultBtn addTarget:self action:@selector(ActionConsultBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [_counselBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [_consultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
    gradientLayer0.cornerRadius = 21.666666666666668;
    gradientLayer0.frame = _consultBtn.bounds;
    gradientLayer0.colors = @[
                              (id)[UIColor colorWithRed:0.0f/255.0f green:132.0f/255.0f blue:244.0f/255.0f alpha:1.0f].CGColor,
                              (id)[UIColor colorWithRed:0.0f/255.0f green:172.0f/255.0f blue:240.0f/255.0f alpha:1.0f].CGColor];
    gradientLayer0.locations = @[@0, @1];
    [gradientLayer0 setStartPoint:CGPointMake(0, 1)];
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
    _appointBtn.layer.cornerRadius = 21.5 *SIZE + 17;
    _appointBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_appointBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [_counselBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [_appointBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CAGradientLayer *gradientLayer1 = [[CAGradientLayer alloc] init];
    gradientLayer1.cornerRadius = 10 *SIZE;
    gradientLayer1.frame = _appointBtn.bounds;
    gradientLayer1.colors = @[
                              (id)[UIColor colorWithRed:0.0f/255.0f green:132.0f/255.0f blue:244.0f/255.0f alpha:1.0f].CGColor,
                              (id)[UIColor colorWithRed:0.0f/255.0f green:170.0f/255.0f blue:238.0f/255.0f alpha:1.0f].CGColor];
    gradientLayer1.locations = @[@0, @1];
    [gradientLayer1 setStartPoint:CGPointMake(0, 1)];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 *SIZE, 273 *SIZE, 13 *SIZE)];
    label1.textColor = CLWhiteColor;
    label1.text = @"预约看房";
    label1.font = [UIFont systemFontOfSize:13 *SIZE];
    label1.textAlignment = NSTextAlignmentCenter;;
    [_appointBtn addSubview:label1];
    [self.view addSubview:_appointBtn];
}

@end
