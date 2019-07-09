//
//  NewRoomProjectDetailDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewRoomProjectDetailDetailVC.h"

#import "TitleContentBaseCell.h"
#import "LisenceCell.h"

@interface NewRoomProjectDetailDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_titlelist;
    NSMutableArray *_contentlist;
}
@property (nonatomic , strong) UITableView *Mytableview;

@end

@implementation NewRoomProjectDetailDetailVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initDataSouce];
    [self initUI];
}

-(void)initDataSouce
{
    _titlelist = [NSMutableArray arrayWithArray:@[@[@"项目名称",@"楼盘状态",@"开发商",@"区域位置",@"设计公司",@"楼盘地址",@"售楼处地址"],@[@"建筑类型",@"均价",@"价格区间",@"占地面积",@"装修标准",@"建筑面积",@"容积率",@"绿化率",@"规划户数",@"规划车位"],@[@"物业类型",@"物业公司",@"物业费",@"供暖方式",@"供水类型",@"供电类型"]]];
    _contentlist = [@[] mutableCopy];
//    [self RequestMethod];
}



#pragma mark  ---  delegate  ---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *arr = _titlelist[section];
    return arr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    if (_titlelist.count) {

        return _titlelist.count;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (!section) {

        return 2 *SIZE;
    }
    return 7 *SIZE;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 10*SIZE)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 3) {
        static NSString *CellIdentifier = @"TitleContentBaseCell";

        TitleContentBaseCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[TitleContentBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        }
    
        cell.titleL.text = _titlelist[indexPath.section][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"LisenceCell";
        LisenceCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[LisenceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{



}

-(void)initUI{
    
//    self.titleLabel.text = @"楼盘详情";
    _Mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _Mytableview.rowHeight = UITableViewAutomaticDimension;
    _Mytableview.estimatedRowHeight = 34 *SIZE;
    _Mytableview.backgroundColor = CLLineColor;
    _Mytableview.delegate = self;
    _Mytableview.dataSource = self;
    
    [_Mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_Mytableview];
}

@end
