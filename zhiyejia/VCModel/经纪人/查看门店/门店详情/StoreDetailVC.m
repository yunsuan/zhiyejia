//
//  StoreDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreDetailVC.h"

#import "CheckStoreCell.h"
#import "MyAttentionAgentCell.h"

@interface StoreDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIButton *complaintBtn;

@property (nonatomic, strong) UIButton *agentBtn;
@end

@implementation StoreDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }else{
        
        return _dataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        CheckStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckStoreCell"];
        if (!cell) {
            
            cell = [[CheckStoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CheckStoreCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //    cell.dataDic = _dataArr[indexPath.row];
        
        return cell;
    }else{
        
        MyAttentionAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAttentionAgentCell"];
        if (!cell) {
            
            cell = [[MyAttentionAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyAttentionAgentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        return cell;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"门店详情";
    
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
    //    [_complaintBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_complaintBtn setTitle:@"投诉" forState:UIControlStateNormal];
    [_complaintBtn setBackgroundColor:CLOrangeColor];
    _complaintBtn.layer.cornerRadius = 7 *SIZE;
    [self.view addSubview:_complaintBtn];
    
    _agentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _agentBtn.frame = CGRectMake(217 *SIZE, SCREEN_Height - 50 *SIZE - TAB_BAR_MORE, 133 *SIZE, 43 *SIZE + TAB_BAR_MORE);
    _agentBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    //    [_complaintBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_agentBtn setTitle:@"联系门店" forState:UIControlStateNormal];
    [_agentBtn setBackgroundColor:CLBlueBtnColor];
    _agentBtn.layer.cornerRadius = 7 *SIZE;
    [self.view addSubview:_agentBtn];
}

@end
