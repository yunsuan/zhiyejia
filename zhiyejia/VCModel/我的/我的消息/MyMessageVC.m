//
//  MyMessageVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MyMessageVC.h"

#import "MyMessageCell.h"

@interface MyMessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation MyMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
//    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMessageCell"];
    if (!cell) {
        
        cell = [[MyMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyMessageCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleL.text = @"张三";
    cell.contentL.text = @"最新楼盘信息 项目动态";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"我的消息";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
