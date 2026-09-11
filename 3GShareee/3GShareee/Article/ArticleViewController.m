//
//  ThirdVC.m
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//
#import "ArticleViewController.h"
#import "TextTableViewCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ArticleViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSMutableArray *articlesSection0;
@property (nonatomic, strong) NSMutableArray *articlesSection1;
@property (nonatomic, strong) NSMutableArray *articlesSection2;
@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSegmentedControl];
    [self setupScrollView];
    [self setupTableViews];
    [self createArticles];
}

- (void)setupSegmentedControl {
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"精选文章", @"热门推荐", @"全部文章"]];
    self.segmentedControl.frame = CGRectMake(15, 100, WIDTH - 30, 35);
    self.segmentedControl.selectedSegmentIndex = 0;
    NSDictionary *normalAttr = @{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName: [UIColor grayColor]};
    NSDictionary *selectedAttr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15], NSForegroundColorAttributeName: [UIColor colorWithRed:46/255.0 green:140/255.0 blue:250/255.0 alpha:1.0]};
    [self.segmentedControl setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    [self.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
}

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 135, WIDTH, HEIGHT - 150)];
    self.scrollView.contentSize = CGSizeMake(WIDTH * 3, HEIGHT - 150);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
}

- (void)setupTableViews {
    CGFloat tableHeight = HEIGHT - 150;
    
    self.tableView01 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, tableHeight) style:UITableViewStylePlain];
    self.tableView01.delegate = self;
    self.tableView01.dataSource = self;
    self.tableView01.backgroundColor = [UIColor whiteColor];
    self.tableView01.showsVerticalScrollIndicator = NO;
    self.tableView01.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView02 = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, tableHeight) style:UITableViewStylePlain];
    self.tableView02.delegate = self;
    self.tableView02.dataSource = self;
    self.tableView02.backgroundColor = [UIColor whiteColor];
    self.tableView02.showsVerticalScrollIndicator = NO;
    self.tableView02.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView03 = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH * 2, 0, WIDTH, tableHeight) style:UITableViewStylePlain];
    self.tableView03.delegate = self;
    self.tableView03.dataSource = self;
    self.tableView03.backgroundColor = [UIColor whiteColor];
    self.tableView03.showsVerticalScrollIndicator = NO;
    self.tableView03.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView01 registerClass:[TextTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView02 registerClass:[TextTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView03 registerClass:[TextTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.scrollView addSubview:self.tableView01];
    [self.scrollView addSubview:self.tableView02];
    [self.scrollView addSubview:self.tableView03];
}

- (void)createArticles {
    UIImage *defaultImage = [UIImage systemImageNamed:@"photo"];
    
    self.articlesSection0 = [NSMutableArray arrayWithArray:@[
        @{@"thumbnail": [UIImage imageNamed:@"article1"] ?: defaultImage, @"title": @"如期而至", @"author": @"SHARE 钢蛋", @"category": @"", @"time": @"16", @"isLiked": @NO, @"likeCount": @"100"},
        @{@"thumbnail": [UIImage imageNamed:@"article2"] ?: defaultImage, @"title": @"duck的学问", @"author": @"SHARE 王二麻", @"category": @"", @"time": @"20", @"isLiked": @NO, @"likeCount": @"100"},
        @{@"thumbnail": [UIImage imageNamed:@"article3"] ?: defaultImage, @"title": @"您的故事", @"author": @"SHARE 和尚", @"category": @"", @"time": @"25", @"isLiked": @NO, @"likeCount": @"100"},
        @{@"thumbnail": [UIImage imageNamed:@"article4"] ?: defaultImage, @"title": @"八月的故事", @"author": @"SHARE 二五", @"category": @"", @"time": @"60", @"isLiked": @NO, @"likeCount": @"100"},
        @{@"thumbnail": [UIImage imageNamed:@"article5"] ?: defaultImage, @"title": @"我们终将再见", @"author": @"SHARE 小唐", @"category": @"", @"time": @"60", @"isLiked": @NO, @"likeCount": @"100"}
    ]];
    
    self.articlesSection1 = [self.articlesSection0 mutableCopy];
    self.articlesSection2 = [self.articlesSection0 mutableCopy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView01) return self.articlesSection0.count;
    if (tableView == self.tableView02) return self.articlesSection1.count;
    if (tableView == self.tableView03) return self.articlesSection2.count;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *article;
    if (tableView == self.tableView01) {
        article = self.articlesSection0[indexPath.section];
    } else if (tableView == self.tableView02) {
        article = self.articlesSection1[indexPath.section];
    } else {
        article = self.articlesSection2[indexPath.section];
    }

    id thumbnail = article[@"thumbnail"];
    NSString *title = article[@"title"];
    NSString *author = article[@"author"];
    NSString *category = article[@"category"];
    NSString *time = article[@"time"];
    BOOL isLiked = [article[@"isLiked"] boolValue];
    NSInteger likeCount = [article[@"likeCount"] integerValue];

    [cell configureCellWithThumbnail:thumbnail
                               title:title
                              author:author
                            category:category
                                time:time
                             isLiked:isLiked
                           likeCount:likeCount];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.segmentedControl.selectedSegmentIndex = page;
    }
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    CGFloat offsetX = sender.selectedSegmentIndex * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

@end
