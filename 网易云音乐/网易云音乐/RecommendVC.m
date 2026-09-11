//
//  recommendVC.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/9.
//

#import "RecommendVC.h"
#import "FirstTableViewCell.h"
#import "settingViewController.h"
#import "settingTableViewCell.h"
#import "NightModeManager.h"
#import "RightViewController.h"
@interface RecommendVC ()

@end

@implementation RecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftbtn = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"caidan"] style: UIBarButtonItemStylePlain target: self action: @selector(pressMenu)];
    self.rightbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tinggeshiqu"] style:UIBarButtonItemStylePlain target:self action:@selector(pressRight)];
    self.navigationItem.leftBarButtonItem = self.leftbtn;
    self.navigationItem.rightBarButtonItem = self.rightbtn;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.searchbar = [[UISearchBar alloc] init];
    self.searchbar.placeholder = @"安和桥 宋冬野";
    self.searchbar.showsSearchResultsButton = YES;
    self.navigationItem.titleView = self.searchbar;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat bannerHeight = screenWidth * 16.0 / 9.0;
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.tableview];
    
    [self.tableview registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"recommand"];
    [self.tableview registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"guessyoulike"];
    [self.tableview registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"poster"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateAppearance)
                                                 name:@"NightModeChangedNotification"
                                               object:nil];
    [self updateAppearance];
}

- (void)pressRight {
    RightViewController *detailVC = [[RightViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateAppearance {
    BOOL isNight = [NightModeManager sharedManager].isNightMode;
    if (isNight) {
        self.view.backgroundColor = [UIColor blackColor];
        self.tableview.backgroundColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
        
        self.searchbar.barTintColor = [UIColor darkGrayColor];
        self.searchbar.searchTextField.backgroundColor = [UIColor darkGrayColor];
        self.searchbar.searchTextField.textColor = [UIColor whiteColor];
    } else {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
        self.tableview.backgroundColor = [UIColor systemBackgroundColor];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
        self.searchbar.barTintColor = [UIColor whiteColor];
        self.searchbar.searchTextField.backgroundColor = [UIColor whiteColor];
        self.searchbar.searchTextField.textColor = [UIColor blackColor];
    }
    [self.tableview reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200;
    } else if (indexPath.section == 1) {
        return 240;
    } else if (indexPath.section == 2) {
        return 220;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommand" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 1) {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"guessyoulike" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 2) {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"poster" forIndexPath:indexPath];
        return cell;
    } else {
        return nil;
    }
}

-(void) pressMenu {
    SettingViewController *settingView = [[SettingViewController alloc] init];
    settingView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    settingView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:settingView animated:YES completion:nil];
}

@end
