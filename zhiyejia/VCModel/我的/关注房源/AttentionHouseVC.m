//
//  AttentionHouseVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/3.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AttentionHouseVC.h"

#import "SecHouseCell.h"
#import "RentHouseCell.h"

@interface AttentionHouseVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation AttentionHouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:PersonalGetSubList_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"][@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
       
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseCell"];
    if (!cell) {
        
        cell = [[SecHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecHouseCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [BaseRequest GET:PersonalCancelFocusHouse_URL parameters:@{@"focus_id":_dataArr[indexPath.row][@"focus_id"]} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)initUI{
    
    self.titleLabel.text = @"关注房源";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSelectionStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
