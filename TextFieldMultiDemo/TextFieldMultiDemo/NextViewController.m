//
//  NextViewController.m
//  TextFieldMultiDemo
//
//  Created by wanglidan on 16/10/19.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

#import "NextViewController.h"
#import "NextCell.h"
#import "NextModel.h"

@interface NextViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSIndexPath *selected;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"NEXT";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _dataSource = [NSMutableArray array];
    _titleArray = @[@"单位名称", @"单位电话", @"单位地址", @"每月工资", @"单位名称", @"单位电话", @"单位地址", @"每月工资", @"单位名称", @"单位电话"];
    for (int i = 0; i < _titleArray.count; i++) {
        NextModel *model = [[NextModel alloc] init];
        model.title = _titleArray[i];
        model.height = 45;
        [_dataSource addObject:model];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];

}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = NSStringFromClass([NextCell class]);
    NextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
    }
    cell.model = _dataSource[indexPath.row];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NextModel *model = _dataSource[indexPath.row];
    return model.height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
