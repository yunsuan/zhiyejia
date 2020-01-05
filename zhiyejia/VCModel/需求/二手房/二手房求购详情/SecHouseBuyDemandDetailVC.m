//
//  SecHouseBuyDemandDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDemandDetailVC.h"

#import "SecHouseCompanyDetailVC.h"
#import "SecHouseBuyDemandDetailRecommendVC.h"

#import "RightBtnColorHeader.h"
#import "SecHouseBuyDetailCell.h"
#import "SecHouseBuyDemandDetailRecommendCell.h"
#import "SecHouseBuyDemandDetailAgentCell.h"
#import "SecHouseBuyDemandDetailHouseCell.h"

@interface SecHouseBuyDemandDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation SecHouseBuyDemandDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }
    return 40 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    RightBtnColorHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RightBtnColorHeader"];
    if (!header) {
        
        header = [[RightBtnColorHeader alloc] initWithReuseIdentifier:@"RightBtnColorHeader"];
    }
    
    if (section == 0) {
        
//        header.titleL.text = @"房源详情";
//        header.contentL.text = @"已成交";
    }else if (section == 1){
        
        header.titleL.text = @"推荐房源";
    }else if (section == 2){
        
        header.titleL.text = @"服务经纪人";
    }else if (section == 3){
        
        header.titleL.text = @"交易详情";
    }else{
        
        header.titleL.text = @"看房记录";
    }
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        SecHouseBuyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseBuyDetailCell"];
        if (!cell) {
            
            cell = [[SecHouseBuyDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseBuyDetailCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = @{};
        return cell;
    }else if (indexPath.section == 1){
        
        SecHouseBuyDemandDetailRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseBuyDemandDetailRecommendCell"];
        if (!cell) {
            
            cell = [[ SecHouseBuyDemandDetailRecommendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseBuyDemandDetailRecommendCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = @{};
        return cell;
    }else if (indexPath.section == 2){
        
        SecHouseBuyDemandDetailAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseBuyDemandDetailAgentCell"];
        if (!cell) {
            
            cell = [[SecHouseBuyDemandDetailAgentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseBuyDemandDetailAgentCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = @{};
        return cell;
    }else{
        
        SecHouseBuyDemandDetailHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseBuyDemandDetailHouseCell"];
        if (!cell) {
                   
            cell = [[SecHouseBuyDemandDetailHouseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseBuyDemandDetailHouseCell"];
        }
            
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
               
        cell.dataDic = @{};
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        SecHouseBuyDemandDetailRecommendVC *nextVC = [[SecHouseBuyDemandDetailRecommendVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"发布详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
