//
//  CheckStoreVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CheckStoreVC.h"

#import "StoreDetailVC.h"

#import "CheckStoreCell.h"

@interface CheckStoreVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation CheckStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;//_dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CheckStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckStoreCell"];
    if (!cell) {
        
        cell = [[CheckStoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CheckStoreCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreDetailVC *nextVC = [[StoreDetailVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = YES;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 40 *SIZE, SCREEN_Width, SCREEN_Height - STATUS_BAR_HEIGHT - 86 *SIZE - 40 *SIZE) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
}

@end
