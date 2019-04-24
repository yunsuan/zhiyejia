//
//  CheckAgentVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CheckAgentVC.h"

#import "AgentDetailVC.h"

#import "MyAttentionAgentCell.h"

@interface CheckAgentVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation CheckAgentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;//_dataArr.count;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyAttentionAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAttentionAgentCell"];
    if (!cell) {
        
        cell = [[MyAttentionAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyAttentionAgentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AgentDetailVC *nextVC = [[AgentDetailVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = YES;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
}

@end
