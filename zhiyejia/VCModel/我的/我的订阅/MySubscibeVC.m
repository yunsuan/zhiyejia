//
//  MySubscibeVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MySubscibeVC.h"

#import "NewRoomProjectDetailVC.h"
#import "SecRoomProjectDetailVC.h"

#import "NewRoomCell.h"
#import "SecRoomCell.h"

@interface MySubscibeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation MySubscibeVC

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
    
    [BaseRequest GET:PersonalGetFocusProjectList_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
            [self->_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([key isEqualToString:@"project_tags"] || [key isEqualToString:@"property_tags"]) {
                
                if ([obj isKindOfClass:[NSArray class]]) {
                    
                    
                }else{
                    
                    [tempDic setObject:@[] forKey:key];
                }
            }else{
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [tempDic setObject:@"" forKey:key];
                }else{
                    
                    [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }
            }
        }];
        [_dataArr addObject:tempDic];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_dataArr[indexPath.row][@"sub_type"] integerValue] == 0) {
        
        NewRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomCell"];
        if (!cell) {
            
            cell = [[NewRoomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NewRoomCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = [[NewRoomModel alloc] initWithDictionary:_dataArr[indexPath.row]];
        
        return cell;
    }else{
        
        SecRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecRoomCell"];
        if (!cell) {
            
            cell = [[SecRoomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecRoomCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = [[SecProjectModel alloc] initWithDictionary:_dataArr[indexPath.row]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_dataArr[indexPath.row][@"sub_type"] integerValue] == 0) {
            
        NewRoomModel *model = [[NewRoomModel alloc] initWithDictionary:_dataArr[indexPath.row]];
        NewRoomProjectDetailVC *nextVC = [[NewRoomProjectDetailVC alloc] initWithModel:model];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
            
        SecProjectModel *model = [[SecProjectModel alloc] initWithDictionary:_dataArr[indexPath.row]];
        SecRoomProjectDetailVC *nextVC = [[SecRoomProjectDetailVC alloc] initWithProjectId:model.project_id infoId:model.info_id city:@"0"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"取消订阅";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [BaseRequest GET:CancelFocusProject_URL parameters:@{@"sub_id":_dataArr[indexPath.row][@"sub_id"]} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网路错误"];
    }];
}

- (void)initUI{
    
    self.titleLabel.text = @"我的订阅";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
