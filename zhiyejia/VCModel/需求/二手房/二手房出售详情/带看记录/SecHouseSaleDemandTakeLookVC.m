//
//  SecHouseSaleDemandTakeLookVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseSaleDemandTakeLookVC.h"

#import "SecHouseDemandTakeLookHeader.h"
#import "SecHouseDemandTakeLookCell.h"

@interface SecHouseSaleDemandTakeLookVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation SecHouseSaleDemandTakeLookVC

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
    
    SecHouseDemandTakeLookHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SecHouseDemandTakeLookHeader"];
    if (!header) {

        header = [[SecHouseDemandTakeLookHeader alloc] initWithReuseIdentifier:@"SecHouseDemandTakeLookHeader"];
    }

    header.dataDic = @{};
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecHouseDemandTakeLookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseDemandTakeLookCell"];
    if (!cell) {
        
        cell = [[SecHouseDemandTakeLookCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseDemandTakeLookCell"];
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
