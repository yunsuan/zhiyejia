//
//  AgentDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentDetailVC.h"

#import "TitleRightBtnHeader.h"
#import "MyAttentionAgentCell.h"

@interface AgentDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation AgentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }else{
        
        return UITableViewAutomaticDimension;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return nil;
    }else{
        
        TitleRightBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleRightBtnHeader"];
        if (!header) {
            
            header = [[TitleRightBtnHeader alloc] initWithReuseIdentifier:@"TitleRightBtnHeader"];
        }
        
        if (section == 1) {
            
            header.titleL.text = @"公司认证";
        }else{
            
            header.titleL.text = @"用户评价";
        }
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyAttentionAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAttentionAgentCell"];
    if (!cell) {
        
        cell = [[MyAttentionAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyAttentionAgentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"经纪人详情";
    
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
