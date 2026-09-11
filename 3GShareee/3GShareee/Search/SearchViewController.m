//
//  SecondVC.m
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//
#import "SearchViewController.h"
#import "PlusViewController.h"
#import "SearchResultViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface SearchViewController ()<UISearchBarDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"搜索";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:26];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shangchuantupian"] style:UIBarButtonItemStylePlain target:self action:@selector(pressPlus)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.barTintColor = [UIColor colorWithRed:(230.0/255) green:(222.0/255) blue:(220.0/255) alpha:1];
    self.searchBar.placeholder = @"搜索 用户名 作品分类 文章";
    self.searchBar.showsSearchResultsButton = YES;
    self.searchBar.searchResultsButtonSelected = YES;
    self.searchBar.delegate = self;
    self.searchBar.frame = CGRectMake(0, 100, WIDTH, 55);
    [self.view addSubview:self.searchBar];
    
    self.Buttons1 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/2 - 185, 175, 85, 30)];
    self.Buttons1.image = [UIImage imageNamed:@"fenlei.png"];
    UIImageView *lineView1 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/2 - 185, 200, 370, 5)];
    lineView1.image = [UIImage imageNamed:@"home_line.png"];
    self.Buttons2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/2 - 185, 355, 85, 30)];
    self.Buttons2.image = [UIImage imageNamed:@"tuijian.png"];
    UIImageView *lineView2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/2 - 185, 380, 370, 5)];
    lineView2.image = [UIImage imageNamed:@"home_line.png"];
    self.Buttons3 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/2 - 185, 485, 85, 30)];
    self.Buttons3.image = [UIImage imageNamed:@"shijian.png"];
    UIImageView *lineView3 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/2 - 185, 510, 370, 5)];
    lineView3.image = [UIImage imageNamed:@"home_line.png"];
    
    [self.view addSubview:self.Buttons1];
    [self.view addSubview:lineView1];
    [self.view addSubview:self.Buttons2];
    [self.view addSubview:lineView2];
    [self.view addSubview:self.Buttons3];
    [self.view addSubview:lineView3];
    
    NSArray *arrayLabel = @[@"平面设计", @"网页设计", @"UI/icon", @"插画/手绘", @"虚拟与设计", @"影视", @"摄影", @"其他", @"人气最高", @"收藏最多", @"评论最多", @"编辑精选", @"30分钟前", @"1小时前", @"1月前", @"1年前"];
    
    NSArray *rowY = @[@235, @295, @420, @545];
    for (int row = 0; row < 4; row++) {
        for (int col = 0; col < 4; col++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(WIDTH/2 - 185 + 95 * col, [rowY[row] floatValue], 85, 30);
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:arrayLabel[row * 4 + col] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.selected = NO;
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = YES;
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
        }
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)pressPlus {
    PlusViewController *plusView = [[PlusViewController alloc] init];
    [self.navigationController pushViewController:plusView animated:YES];
}

- (void)pressBtn:(UIButton *)btn {
    if (btn.selected == NO) {
        btn.selected = YES;
        btn.backgroundColor = [UIColor systemBlueColor];
    } else {
        btn.selected = NO;
        btn.backgroundColor = [UIColor whiteColor];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([self.searchBar.text isEqualToString:@"大白"]) {
        SearchResultViewController *searchResultsView = [[SearchResultViewController alloc] init];
        [self.navigationController pushViewController:searchResultsView animated:YES];
    }
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

@end
