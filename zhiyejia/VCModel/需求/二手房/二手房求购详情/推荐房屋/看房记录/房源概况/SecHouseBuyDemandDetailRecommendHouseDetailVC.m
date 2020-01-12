//
//  SecHouseBuyDemandDetailRecommendHouseDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/8.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDemandDetailRecommendHouseDetailVC.h"

#import "SecHouseBuyDemandDetailRecommendPriceCell.h"
#import "SecHouseBuyDemandDetailRecommendDymCell.h"

@interface SecHouseBuyDemandDetailRecommendHouseDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation SecHouseBuyDemandDetailRecommendHouseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        SecHouseBuyDemandDetailRecommendPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseBuyDemandDetailRecommendPriceCell"];
        if (!cell) {
            
            cell = [[SecHouseBuyDemandDetailRecommendPriceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseBuyDemandDetailRecommendPriceCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = @{};
        
        return cell;
    }
    SecHouseBuyDemandDetailRecommendDymCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseBuyDemandDetailRecommendDymCell"];
    if (!cell) {
        
        cell = [[SecHouseBuyDemandDetailRecommendDymCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseBuyDemandDetailRecommendDymCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = @{};
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"房源概况";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
