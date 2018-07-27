//
//  CMTestModulesConfigController.m
//  CMTestModules
//
//  Created by 智借iOS on 2018/7/25.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMTestModulesConfigController.h"

@interface CMTestModulesConfigController () <UITableViewDelegate,UITableViewDataSource>

/**列表*/
@property (nonatomic,strong) UITableView *tableView;
/**数组*/
@property (nonatomic,strong) NSArray *dataArr;
/**屏幕帧数开关*/
@property (nonatomic,strong) UISwitch *fpsSwitch;


@end

@implementation CMTestModulesConfigController

- (UISwitch *)fpsSwitch {
    
    if (!_fpsSwitch) {
        _fpsSwitch = [[UISwitch alloc]init];
        
        [_fpsSwitch addTarget:self action:@selector(fpsSwitchAction:) forControlEvents:UIControlEventValueChanged];
        
        
    }
    return _fpsSwitch;
    
}

- (NSArray *)dataArr {
    
    if (!_dataArr) {
        _dataArr = @[@"域名设置",@"屏幕帧数"];
    }
    return _dataArr;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSubViews];

}

- (void)initSubViews {
    
    self.title = @"调试配置";
    
    [self.view addSubview:self.tableView];
    
    [self setTableViewSeparator];
}



- (void)fpsSwitchAction:(UISwitch *)sender {
    
    
    
}



- (void)showChooseRequestAddressAlert {
    
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"请选择网络制式" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *releaseAddress = [UIAlertAction actionWithTitle:@"线上正式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *debugAddress = [UIAlertAction actionWithTitle:@"线上测试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertVC addAction:releaseAddress];
    [alertVC addAction:debugAddress];
    [alertVC addAction:cancelAction];

    [self presentViewController:alertVC animated:YES completion:nil];
    
    
    
    
}


#pragma mark --- cell分割线左边距顶边

//设置tableView的分割线,使用时手动调用该方法
-(void)setTableViewSeparator {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    self.separatorColor = [UIColor lightGrayColor];
    //分割线左边距设置并配合重写willDisplayCell方法
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

//重新改方法设置分割线左边距
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}



#pragma mark --- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataArr.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:NSStringFromClass(self.class)];
        
    }
    
    [self resolveCell:cell IndexPath:indexPath];
    
    return cell;
    
}



- (void)resolveCell:(UITableViewCell *)cell IndexPath:(NSIndexPath *)indexPath {

    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.row == 0) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
    } else if (indexPath.row == 1) {
        
        
        CGPoint center = cell.contentView.center;
        center.x = self.tableView.bounds.size.width - self.fpsSwitch.bounds.size.width;
        self.fpsSwitch.center = center;
        [cell.contentView addSubview:self.fpsSwitch];
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        
        [self showChooseRequestAddressAlert];
        
    } else if (indexPath.row == 1) {
        
        
        
        
    }
    
}

@end
