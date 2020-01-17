//
//  SecHouseSaleDemandWaitDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseSaleDemandWaitDetailVC.h"

#import "BaseColorHeader.h"
#import "SecHouseSaleDemandDetailHouseCell.h"
#import "SecHouseSaleDemandDetailDymCell.h"
#import "SecHouseRemindCell.h"

@interface SecHouseSaleDemandWaitDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_recommend_id;
    
    NSDictionary *_dataDic;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation SecHouseSaleDemandWaitDetailVC

- (instancetype)initWithRecomendId:(NSString *)recommend_id
{
    self = [super init];
    if (self) {
        
        _recommend_id = recommend_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"发布详情";
    [self RequestMethod];
}

- (void)RequestMethod{

    [BaseRequest GET:NeedSaleWaitDeail_URL parameters:@{@"recommend_id":_recommend_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataDic = resposeObject[@"data"];
    
            [self->_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
        [self initUI];
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}


- (void)ActionRightBtn:(UIButton *)btn{
    
    FailView *view = [[FailView alloc] initWithFrame:self.view.bounds];
    view.failViewBlock = ^(NSString *str) {
        
        NSString *reason;
        if (str.length) {
            
            reason = str;
        }else{
            
            reason = @" ";
        }
        [BaseRequest POST:NeedSaleCancel_URL parameters:@{@"recommend_id":self->_recommend_id,@"disabled_reason":reason} success:^(id  _Nonnull resposeObject) {

            if ([resposeObject[@"code"] integerValue] == 200) {

                [self showContent:@"取消成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                    if (self.secHouseSaleDemandWaitDetailVCBlock) {

                        self.secHouseSaleDemandWaitDetailVCBlock();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{

                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {

            [self showContent:@"网络错误"];
        }];
    };
    [self.view addSubview:view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseColorHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseColorHeader"];
    if (!header) {
        
        header = [[BaseColorHeader alloc] initWithReuseIdentifier:@"BaseColorHeader"];
    }
    
    header.contentL.text = @"";
    if (section == 0) {
        
        header.titleL.text = @"房源详情";
        header.contentL.text = self->_dataDic[@"current_state_name"];
    }else if (section == 1){
        
//        header.titleL.text = @"房源动态";
//    }else{
        
        header.titleL.text = @"中介服务详情";
    }
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return 1;
    }else if (section == 2){
        
        return 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        SecHouseSaleDemandDetailHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseSaleDemandDetailHouseCell"];
        if (!cell) {
            
            cell = [[ SecHouseSaleDemandDetailHouseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseSaleDemandDetailHouseCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = self->_dataDic;
        return cell;
//    }else if (indexPath.section == 1){
        
//        if (indexPath.row == 0) {
            
//            SecHouseSaleDemandDetailDymCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseSaleDemandDetailDymCell"];
//            if (!cell) {
//
//                cell = [[ SecHouseSaleDemandDetailDymCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseSaleDemandDetailDymCell"];
//            }
//
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            cell.dataDic = @{};
//            return cell;
////        }
//        TitleContentRightBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleContentRightBtnCell"];
//        if (!cell) {
//
//            cell = [[ TitleContentRightBtnCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TitleContentRightBtnCell"];
//        }
//
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        cell.titleL.text = @"带看记录";
//        cell.contentL.text = @"最近带看 2019.1.1";
//        return cell;
    }else{
        
        SecHouseRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseRemindCell"];
        if (!cell) {
            
            cell = [[SecHouseRemindCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseRemindCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentL.text = @"发布成功！已通知全城经纪人，请保持手机联络畅通，经纪人将会在周一至周日8:00-20:00给你回电。";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section == 1) {
//        
//        if (indexPath.row == 1) {
//            
//            SecHouseSaleDemandTakeLookVC *nextVC = [[SecHouseSaleDemandTakeLookVC alloc] init];
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else if (indexPath.row == 2){
//            
//            SecHouseSaleDemandMaintainVC *nextVC = [[SecHouseSaleDemandMaintainVC alloc] init];
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else if (indexPath.row == 3){
//            
//            SecHouseSaleDemandDealVC *nextVC = [[SecHouseSaleDemandDealVC alloc] init];
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }
//    }
//    if (indexPath.section == 2) {
//        
//        SecHouseCompanyDetailVC *nextVC = [[SecHouseCompanyDetailVC alloc] init];
//        [self.navigationController pushViewController:nextVC animated:YES];
//    }
}

- (void)initUI{
    
    self.rightBtn.hidden = NO;
    if ([self.status integerValue]) {
        
        self.rightBtn.hidden = YES;
    }
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    
    [self.rightBtn setTitle:@"取消发布" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
