//
//  DemandDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DemandDetailVC.h"

#import "TitleBaseHeader.h"
#import "DemandListCell.h"
#import "DemandAgentCell.h"
#import "DemandInfoCell.h"

@interface DemandDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation DemandDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        
        return 6;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return UITableViewAutomaticDimension;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        TitleBaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleBaseHeader"];
        if (!header) {
            
            header = [[TitleBaseHeader alloc] initWithReuseIdentifier:@"TitleBaseHeader"];
        }
        
        header.titleL.text = @"接单信息";
        
        return header;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        DemandListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemandListCell"];
        if (!cell) {
            
            cell = [[DemandListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DemandListCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.codeL.text = @"需求单号：23123123";
        cell.timeL.text = @"发布时间：2017-12-15 13：00：00";
        return cell;
    }else{
        
        if (indexPath.section == 1) {
            
            DemandAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemandAgentCell"];
            if (!cell) {
                
                cell = [[DemandAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DemandAgentCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = @{};
            return cell;
        }else{
            
            DemandInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemandInfoCell"];
            if (!cell) {
                
                cell = [[DemandInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DemandInfoCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentL.text = @"城市区域：成都市 青羊区 清江西路";
            return cell;
        }
    }
    
}

- (void)initUI{
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height) style:UITableViewStylePlain];
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
