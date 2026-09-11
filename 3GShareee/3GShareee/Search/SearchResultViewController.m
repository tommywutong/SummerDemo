//
//  SearchResultViewController.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/17.
//

#import "SearchResultViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#import "PlusViewController.h"
#import "TextTableViewCell.h"

@interface SearchResultViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255 green:222.0/255 blue:220.0/255 alpha:1];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"搜索";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:26];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"holidayfanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pressReturn)];
    self.navigationItem.leftBarButtonItem = btn;
    btn.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shangchuantupian"] style:UIBarButtonItemStylePlain target:self action:@selector(pressPlus)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.text = @"大白";
    self.searchBar.barTintColor = [UIColor colorWithRed:230.0/255 green:222.0/255 blue:220.0/255 alpha:1];
    self.searchBar.showsSearchResultsButton = YES;
    self.searchBar.searchResultsButtonSelected = YES;
    self.searchBar.frame = CGRectMake(0, 100, WIDTH, 55);
    [self.view addSubview:self.searchBar];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, WIDTH, self.view.bounds.size.height - 160) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[TextTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self setupData];
}

- (void)setupData {
    self.dataArray = [@[
        @{
            @"thumbnail": @"dabai1",
            @"title": @"Icon of Baymax",
            @"author": @"小白",
            @"category": @"原创-ui-ocon",
            @"time": @"15",
            @"isLiked": @NO
        },
        @{
            @"thumbnail": @"dabai2",
            @"title": @"每个人都需要一个大白",
            @"author": @"小王",
            @"category": @"原创作品-摄影",
            @"time": @"50",
            @"isLiked": @NO
        }
    ] mutableCopy];
}

- (void)pressReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressPlus {
    PlusViewController *upImageView = [[PlusViewController alloc] init];
    [self.navigationController pushViewController:upImageView animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.itemIndex = indexPath.row;
    
    NSDictionary *item = self.dataArray[indexPath.row];
    UIImage *thumbnail = [UIImage imageNamed:item[@"thumbnail"]];
    NSString *title = item[@"title"];
    NSString *author = item[@"author"];
    NSString *category = item[@"category"];
    NSString *time = item[@"time"];
    BOOL isLiked = [item[@"isLiked"] boolValue];
    NSInteger likeCount = [item[@"likeCount"] integerValue];
    
    [cell configureCellWithThumbnail:thumbnail title:title author:author category:category time:time isLiked:isLiked likeCount:likeCount];
    
    return cell;
}

@end
