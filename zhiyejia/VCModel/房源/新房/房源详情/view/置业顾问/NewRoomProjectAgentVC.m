//
//  NewRoomProjectAgentVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/5.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "NewRoomProjectAgentVC.h"

#import "NewRoomProjectAgentMoreCell.h"

@interface NewRoomProjectAgentVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation NewRoomProjectAgentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewRoomProjectAgentMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomProjectAgentMoreCell"];
    if (!cell) {
        
        cell = [[NewRoomProjectAgentMoreCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NewRoomProjectAgentMoreCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = @{};
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

- (void)initUI{
    
    self.titleLabel.text = @"置业顾问";
    
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
