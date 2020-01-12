//
//  SecHouseBuyDemandDetailRecommendLookRecordVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/7.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDemandDetailRecommendLookRecordVC.h"

#import "SecHouseBuyDemandDetailRecommendLookRecordCell.h"

@interface SecHouseBuyDemandDetailRecommendLookRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation SecHouseBuyDemandDetailRecommendLookRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecHouseBuyDemandDetailRecommendLookRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseBuyDemandDetailRecommendLookRecordCell"];
    if (!cell) {
        
        cell = [[SecHouseBuyDemandDetailRecommendLookRecordCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseBuyDemandDetailRecommendLookRecordCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = @{};
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"房源概况" forState:UIControlStateNormal];
    
    self.titleLabel.text = @"推荐房屋";
    
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
