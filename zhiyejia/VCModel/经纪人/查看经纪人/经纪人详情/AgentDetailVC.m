//
//  AgentDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentDetailVC.h"

#import "ComplaintVC.h"

#import "TitleRightBtnHeader.h"
#import "MyAttentionAgentCell.h"
#import "AgentCompanyCell.h"
#import "AgentCustomCommentCell.h"

@interface AgentDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIButton *complaintBtn;

@property (nonatomic, strong) UIButton *agentBtn;

@end

@implementation AgentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionComplaitBtn:(UIButton *)btn{
    
    ComplaintVC *nextVC = [[ComplaintVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
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
            header.moreBtn.hidden = NO;
            [header.moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
        }else{
            
            header.titleL.text = @"用户评价";
            header.moreBtn.hidden = YES;
        }
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        MyAttentionAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAttentionAgentCell"];
        if (!cell) {
            
            cell = [[MyAttentionAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyAttentionAgentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = @{};//_dataArr[indexPath.row];
        
        return cell;
    }else{
        
        if (indexPath.section == 1) {
            
            AgentCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCompanyCell"];
            if (!cell) {
                
                cell = [[AgentCompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AgentCompanyCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //    cell.dataDic = _dataArr[indexPath.row];
            
            return cell;
        }else{
            
            AgentCustomCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCustomCommentCell"];
            if (!cell) {
                
                cell = [[AgentCustomCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AgentCustomCommentCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //    cell.dataDic = _dataArr[indexPath.row];
            
            return cell;
        }
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"经纪人详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE -  53 *SIZE) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    _complaintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _complaintBtn.frame = CGRectMake(79 *SIZE, SCREEN_Height - 50 *SIZE - TAB_BAR_MORE, 133 *SIZE, 43 *SIZE + TAB_BAR_MORE);
    _complaintBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_complaintBtn addTarget:self action:@selector(ActionComplaitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_complaintBtn setTitle:@"投诉" forState:UIControlStateNormal];
    [_complaintBtn setBackgroundColor:CLOrangeColor];
    _complaintBtn.layer.cornerRadius = 7 *SIZE;
    [self.view addSubview:_complaintBtn];
    
    _agentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _agentBtn.frame = CGRectMake(217 *SIZE, SCREEN_Height - 50 *SIZE - TAB_BAR_MORE, 133 *SIZE, 43 *SIZE + TAB_BAR_MORE);
    _agentBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    //    [_complaintBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_agentBtn setTitle:@"联系经纪人" forState:UIControlStateNormal];
    [_agentBtn setBackgroundColor:CLBlueBtnColor];
    _agentBtn.layer.cornerRadius = 7 *SIZE;
    [self.view addSubview:_agentBtn];

}

@end
