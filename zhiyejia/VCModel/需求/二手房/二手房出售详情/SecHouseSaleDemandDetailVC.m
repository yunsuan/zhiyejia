//
//  SecHouseSaleDemandDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseSaleDemandDetailVC.h"

#import "SecHouseCompanyDetailVC.h"
#import "SecHouseSaleDemandTakeLookVC.h"
#import "SecHouseSaleDemandMaintainVC.h"
#import "SecHouseSaleDemandDealVC.h"

#import "BaseColorHeader.h"
#import "SecHouseSaleDemandDetailHouseCell.h"
#import "SecHouseSaleDemandDetailDymCell.h"
#import "TitleContentRightBtnCell.h"
#import "SecHouseSaleDemandDetailCompanyCell.h"
#import "SecHouseSaleDemandDetailAgentCell.h"
#import "SecHouseSaleDemandServerCell.h"


@interface SecHouseSaleDemandDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation SecHouseSaleDemandDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
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
        header.contentL.text = @"已成交";
    }else if (section == 1){
        
        header.titleL.text = @"房源动态";
    }else{
        
        header.titleL.text = @"中介服务详情";
    }
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return 4;
    }else if (section == 2){
        
        return 3;
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
        
        cell.dataDic = @{};
        return cell;
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            SecHouseSaleDemandDetailDymCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseSaleDemandDetailDymCell"];
            if (!cell) {
                
                cell = [[ SecHouseSaleDemandDetailDymCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseSaleDemandDetailDymCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = @{};
            return cell;
        }
        TitleContentRightBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleContentRightBtnCell"];
        if (!cell) {
            
            cell = [[ TitleContentRightBtnCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TitleContentRightBtnCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleL.text = @"带看记录";
        cell.contentL.text = @"最近带看 2019.1.1";
        return cell;
    }else{
        
        if (indexPath.row == 0) {
            
            SecHouseSaleDemandDetailCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseSaleDemandDetailCompanyCell"];
            if (!cell) {
                
                cell = [[ SecHouseSaleDemandDetailCompanyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseSaleDemandDetailCompanyCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = @{};
            return cell;
        }else{
            
            SecHouseSaleDemandDetailAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseSaleDemandDetailAgentCell"];
            if (!cell) {
                
                cell = [[ SecHouseSaleDemandDetailAgentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseSaleDemandDetailAgentCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = @{};
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 1) {
            
            SecHouseSaleDemandTakeLookVC *nextVC = [[SecHouseSaleDemandTakeLookVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 2){
            
            SecHouseSaleDemandMaintainVC *nextVC = [[SecHouseSaleDemandMaintainVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 3){
            
            SecHouseSaleDemandDealVC *nextVC = [[SecHouseSaleDemandDealVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
    if (indexPath.section == 2) {
        
        SecHouseCompanyDetailVC *nextVC = [[SecHouseCompanyDetailVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"发布详情";
    
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
