//
//  SecHouseSaleDemandMaintainVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseSaleDemandMaintainVC.h"

#import "BaseColorHeader.h"
#import "SecHouseDemandMaintainCell.h"

@interface SecHouseSaleDemandMaintainVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation SecHouseSaleDemandMaintainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return UITableViewAutomaticDimension;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseColorHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseColorHeader"];
    if (!header) {

        header = [[BaseColorHeader alloc] initWithReuseIdentifier:@"BaseColorHeader"];
    }

    header.titleL.text = @"总维护量：30";
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecHouseDemandMaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseDemandMaintainCell"];
    if (!cell) {
        
        cell = [[SecHouseDemandMaintainCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseDemandMaintainCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = @{};
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"公司详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
