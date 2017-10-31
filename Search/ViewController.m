//
//  ViewController.m
//  Search
//
//  Created by WXL-TECH on 2017/10/31.
//  Copyright © 2017年 WXL-TECH. All rights reserved.
//

#import "ViewController.h"

#import "SearchView.h"

#import "SearchViewController.h"

@interface ViewController ()

@property (nonatomic,retain) SearchView * searchView;

@end

@implementation ViewController

- (SearchView *)searchView
{
    if (!_searchView) {
        _searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 2 * 64, 30)];
        _searchView.backgroundColor = [UIColor whiteColor];
        _searchView.layer.cornerRadius = 5;
        _searchView.clipsToBounds = YES;
        _searchView.imageName = @"search";
        _searchView.placeholder = @"搜索";
    }
    return _searchView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configurationNav];
}

- (void) configurationNav
{
    self.navigationController.navigationBar.barTintColor = [UIColor darkTextColor];
    self.navigationItem.titleView = self.searchView;
    
    __weak typeof(self) weakSelf = self;
    self.searchView.searchPushCall = ^{
        SearchViewController * vc = [[SearchViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
