//
//  EventDetailOtherVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/9.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "EventDetailOtherVC.h"

#import "NewRoomCell.h"
#import "EventDetailOtherHeader.h"

@interface EventDetailOtherVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *listTable;

@end

@implementation EventDetailOtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [@[] mutableCopy];
    
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    _listTable.mj_footer.state = MJRefreshStateIdle;

}



- (void)SetData:(NSArray *)data{
    
    
    [_listTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 150 *SIZE;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    EventDetailOtherHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"EventDetailOtherHeader"];
    if (!header) {
        
        header = [[EventDetailOtherHeader alloc] initWithReuseIdentifier:@"EventDetailOtherHeader"];
    }
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomCell"];
    if (!cell) {
        
        cell = [[NewRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    EventDetailVC *nextVC = [[EventDetailVC alloc] initWithStr:_dataArr[indexPath.row][@"url"] titleStr:@"动态详情"];
//    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"活动详情";
    self.navBackgroundView.hidden = NO;
    
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    _listTable.rowHeight = UITableViewAutomaticDimension;
    _listTable.estimatedRowHeight = 100 *SIZE;
    _listTable.backgroundColor = self.view.backgroundColor;
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listTable];
}

@end
