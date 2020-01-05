//
//  SecHouseCompanyDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseCompanyDetailVC.h"

#import "BaseColorHeader.h"
#import "SecHouseSaleDemandServerCell.h"

@interface SecHouseCompanyDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation SecHouseCompanyDetailVC

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


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseColorHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseColorHeader"];
    if (!header) {
        
        header = [[BaseColorHeader alloc] initWithReuseIdentifier:@"BaseColorHeader"];
    }
    
    header.contentL.text = @"";
    if (section == 0) {
        
        header.titleL.text = @"简介";
    }else if (section == 1){
        
        header.titleL.text = @"公司信息";
    }else{
        
        header.titleL.text = @"收费标准";
    }
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecHouseSaleDemandServerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseSaleDemandServerCell"];
    if (!cell) {
        
        cell = [[ SecHouseSaleDemandServerCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseSaleDemandServerCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(20 *SIZE);
        make.top.equalTo(cell.contentView).offset(15 *SIZE);
        make.right.equalTo(cell.contentView).offset(-20 *SIZE);
        make.bottom.equalTo(cell.contentView).offset(-15);
    }];
//    cell.dataDic = @{};
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
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
