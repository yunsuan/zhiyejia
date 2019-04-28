//
//  DemandListVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DemandListVC.h"
#import "DemandDetailVC.h"

#import "DemandListCell.h"

@interface DemandListVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation DemandListVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DemandListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemandListCell"];
    if (!cell) {
        
        cell = [[DemandListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DemandListCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.codeL.text = @"需求单号：23123123";
    cell.timeL.text = @"发布时间：2017-12-15 13：00：00";
    cell.statusL.text = @"已接单";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DemandDetailVC *vc = [[DemandDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initUI{
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
