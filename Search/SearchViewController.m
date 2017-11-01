//
//  SearchViewController.m
//  Search
//
//  Created by WXL-TECH on 2017/10/31.
//  Copyright © 2017年 WXL-TECH. All rights reserved.
//

#import "SearchViewController.h"

#import "SearchNavBar.h"

#import "HistoryKeyViewCell.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SearchNavBar * navBar;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataSource;

@end

static NSString * TABLEVIEWCELLID = @"HistoryKeyViewCell";

@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

/**
 导航栏
 **/
- (SearchNavBar *)navBar
{
    if (!_navBar) {
        _navBar = [[SearchNavBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[[UIApplication sharedApplication] statusBarFrame].size.height + 44)];
        _navBar.imageName = @"search";
        _navBar.placeholder = @"搜索";
        [_navBar setBackgroundColor:[UIColor darkTextColor]];
    }
    return _navBar;
}

/**
 表格视图
 **/
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,[[UIApplication sharedApplication] statusBarFrame].size.height + 44 , [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - 44 ) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorColor = [UIColor darkTextColor];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tableView registerNib:[UINib nibWithNibName:TABLEVIEWCELLID bundle:nil] forCellReuseIdentifier:TABLEVIEWCELLID];
    }
    return _tableView;
}

/**
 数据源
 **/
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configurationNavBar];
    [self configurationTableView];
}

- (void) configurationNavBar
{
    [self.view addSubview:self.navBar];
    
    __weak typeof(self) weakSelf = self;
    self.navBar.searchCancleCall = ^ {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    self.navBar.searchKeyWordCall = ^(NSString *keyword) {
        NSLog(@"搜索的关键词是:%@",keyword);
        [weakSelf showSearchKey:keyword];
        NSArray * dataArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"History_Search"];
        NSMutableArray * dataArray = [NSMutableArray arrayWithArray:dataArr];
        [dataArray addObject:keyword];
        [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"History_Search"];
    };
}

- (void) configurationTableView
{
    [self.view addSubview:self.tableView];
    NSArray * dataArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"History_Search"];
    self.dataSource = dataArr.mutableCopy;
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryKeyViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEWCELLID];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    cell.deleteCurrentKeywordCall = ^{
        [self.dataSource removeObject:self.dataSource[indexPath.row]];
        [[NSUserDefaults standardUserDefaults] setObject:self.dataSource forKey:@"History_Search"];
        [self.tableView reloadData];
    };
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.dataSource.count > 0) {
        return 70;
    }
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.dataSource.count > 0) {
        UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
        UIButton * deleteAll = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteAll setFrame:CGRectMake(50, 35, footer.bounds.size.width - 100, 35)];
        [deleteAll setBackgroundColor:[UIColor darkGrayColor]];
        deleteAll.layer.cornerRadius = 5;
        [deleteAll setTintColor:[UIColor whiteColor]];
        [deleteAll setTitle:@"清除全部" forState:UIControlStateNormal];
        [deleteAll addTarget:self action:@selector(delteAllClick) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:deleteAll];
        return footer;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**搜索之前的关键词**/
    NSString * keyword = self.dataSource[indexPath.row];
    NSLog(@"搜索的关键词是:%@",keyword);
    [self showSearchKey:keyword];
}

/**
 清除所有历史搜索记录
 */
- (void) delteAllClick
{
    [self.dataSource removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setObject:self.dataSource forKey:@"History_Search"];
    [self.tableView reloadData];
}

/**
 显示搜索内容
 **/
- (void) showSearchKey:(NSString *)keyword
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"搜索关键词" message:keyword preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
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
