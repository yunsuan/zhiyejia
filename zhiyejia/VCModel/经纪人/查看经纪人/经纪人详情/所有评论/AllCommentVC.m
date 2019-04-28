//
//  AllCommentVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AllCommentVC.h"

#import "AgentCustomCommentCell.h"

@interface AllCommentVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation AllCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AgentCustomCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCustomCommentCell"];
    if (!cell) {
        
        cell = [[AgentCustomCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AgentCustomCommentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"评价详情";
    
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
