//
//  settingViewController.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/7/13.
//

#import "SettingViewController.h"
#import "MyVC.h"
#import "RecommendVC.h"
#import "NightModeManager.h"

@interface SettingViewController ()
@property (nonatomic, strong) NSArray<NSDictionary *> *modeItems; // 新增数据源
@end

@implementation SettingViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.modeItems = @[
            @{@"icon": @"bubble.right", @"title": @"我的消息", @"subtitle": @"", @"badge": @"55"},
            @{@"icon": @"creditcard", @"title": @"我的云贝", @"subtitle": @"免费兑换黑胶VIP", @"badge": @""},
            @{@"icon": @"paintbrush", @"title": @"装扮中心", @"subtitle": @"呆呆鲨戳你~", @"badge": @""},
            @{@"icon": @"pencil.tip", @"title": @"创作者中心", @"subtitle": @"", @"badge": @""},
            @{@"icon": @"clock", @"title": @"最近播放", @"subtitle": @"8台设备登录", @"badge": @""},
            @{@"icon": @"power", @"title": @"定时关闭", @"subtitle": @"", @"badge": @""},
            @{@"icon": @"cart", @"title": @"商城", @"subtitle": @"", @"badge": @""},
            @{@"icon": @"ticket", @"title": @"云村有票", @"subtitle": @"", @"badge": @""},
            @{@"icon": @"waveform", @"title": @"云推歌", @"subtitle": @"", @"badge": @""}
        ];
        
    self.drawerWidth = 336;
    
    [self setupBackgroundDimmingView];
    [self setupTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(updateAppearance)
                                                   name:@"NightModeChangedNotification"
                                                 object:nil];
    
    [self updateAppearance];
}

//在当前页面上加一个半透明黑色的背景蒙层，并且能点击关闭设置面板
- (void)setupBackgroundDimmingView {
    self.backgroundDimmingView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backgroundDimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.backgroundDimmingView.alpha = 0;
    [self.view addSubview:self.backgroundDimmingView];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSetting)];
    [self.backgroundDimmingView addGestureRecognizer:tapGesture];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(-self.drawerWidth, 0, self.drawerWidth, [UIScreen mainScreen].bounds.size.height)
                                                 style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor systemBackgroundColor];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerClass:[settingTableViewCell class] forCellReuseIdentifier:@"user"];
    [self.tableView registerClass:[settingTableViewCell class] forCellReuseIdentifier:@"heijiao"];
    [self.tableView registerClass:[settingTableViewCell class] forCellReuseIdentifier:@"mode"];
    [self.tableView registerClass:[settingTableViewCell class] forCellReuseIdentifier:@"night"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0, 0, self.drawerWidth, [UIScreen mainScreen].bounds.size.height);
        self.backgroundDimmingView.alpha = 1;
    }];
}

- (void)dismissSetting {
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(-self.drawerWidth, 0, self.drawerWidth, [UIScreen mainScreen].bounds.size.height);
        self.backgroundDimmingView.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)updateAppearance {
    BOOL isNightMode = [NightModeManager sharedManager].isNightMode;

    if (isNightMode) {
        self.tableView.backgroundColor = [UIColor blackColor];
        self.tabBarController.tabBar.backgroundColor = [UIColor darkGrayColor];
        self.tabBarController.tabBar.barTintColor = [UIColor darkGrayColor];
        self.tabBarController.tabBar.tintColor = [UIColor redColor]; // 设置选中颜色
    } else {
        UIColor *wechatBackgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        self.tableView.backgroundColor = wechatBackgroundColor;
        self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
        self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
        self.tabBarController.tabBar.tintColor = [UIColor grayColor];
    }
    [self.tableView reloadData];
}

- (void)nightModeSwitchChanged:(UISwitch *)sender {
    [[NightModeManager sharedManager] toggleNightMode:sender.isOn];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return self.modeItems.count;
    } else if (section == 3) {
        return 1;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    } else if (indexPath.section == 1) {
        return 100;
    } else if (indexPath.section == 2) {
        return 50;
    } else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    settingTableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"user" forIndexPath:indexPath];
    } else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"heijiao" forIndexPath:indexPath];
    } else if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"mode" forIndexPath:indexPath];
        NSDictionary *item = self.modeItems[indexPath.row];
        [cell configureWithIcon:item[@"icon"]
                         title:item[@"title"]
                      subtitle:item[@"subtitle"]
                         badge:item[@"badge"]];
    } else if (indexPath.section == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"night" forIndexPath:indexPath];
        BOOL isNightMode = [NightModeManager sharedManager].isNightMode;
        cell.nightSwitch.on = isNightMode;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

@end
