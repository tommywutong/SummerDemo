//
//  myVC.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/9.
//

#import "MyVC.h"
#import "ToolbarTableViewCell.h"
#import "UserInfoCell.h"
#import "SegmentTabCell.h"
#import "PhotoWallVC.h"
#import "SettingViewController.h"
#import "settingTableViewCell.h"

@interface MyVC ()<UITableViewDelegate, UITableViewDataSource,
                   ToolbarTableViewCellDelegate, SegmentTabCellDelegate, PhotoWallDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, strong) NSArray *musicContent;
@property (nonatomic, strong) NSArray *podcastContent;
@property (nonatomic, strong) NSArray *noteContent;
@property(nonatomic, strong) UIImage* selectedAvater;
@property (nonatomic, strong) UIImage *currentAvatar;
@end


@implementation MyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundView.image = [UIImage imageNamed:@"back.jpg"];
    backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    backgroundView.alpha = 1.0;
    [self.view insertSubview:backgroundView atIndex:0];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;

    [self.tableView registerClass:[UserInfoCell class] forCellReuseIdentifier:@"UserInfoCell"];
    [self.tableView registerClass:[ToolbarTableViewCell class] forCellReuseIdentifier:@"ToolbarCell"];
    [self.tableView registerClass:[SegmentTabCell class] forCellReuseIdentifier:@"SegmentTabCell"];
    [self.view addSubview:self.tableView];
    [self configureNavigationBar];
    [self setupData];
}

-(void) setupData {
    self.selectedSegmentIndex = 0;
    self.musicContent = @[
        @{
            @"title": @"我爱的音乐",
            @"detail": @"1161首·2048次播放",
            @"icon": @"ho",
            @"type": @"featured"
        },
        @{
            @"title": @"听歌排行",
            @"detail": @"累计听歌10887首",
            @"icon": @"paii",
            @"type": @"normal"
        },
        @{
            @"title": @"老毕灯",
            @"detail": @"歌单·11首·A5pkRd",
            @"icon": @"h",
            @"type": @"normal"
        },
        @{
            @"title": @"PKU",
            @"detail": @"歌单·18首·A5pkRd",
            @"icon": @"pku",
            @"type": @"normal"
        },
        @{
            @"title": @"粤语",
            @"detail": @"歌单·2首·A5pkRd",
            @"icon": @"yueyu",
            @"type": @"normal"
        },
        @{
            @"title": @"A5pkRd的2024年度歌单",
            @"detail": @"歌单·10首·A5pkRd",
            @"icon": @"nian",
            @"type": @"normal"
        },
        @{
            @"title": @"周杰伦",
            @"detail": @"歌单·197首·A5pkRd",
            @"icon": @"zhou",
            @"type": @"normal"
        },
        @{
            @"title": @"A5pkRd十年精选特辑",
            @"detail": @"20首",
            @"icon": @"shi",
            @"type": @"normal"
        }
    ];
    self.podcastContent = @[
        @{
            @"title": @"绝密档案",
            @"detail": @"绝密档案官方",
            @"icon": @"dang",
            @"type": @"normal"
        },
        @{
            @"title": @"你一生的故事、时光主理人",
            @"detail": @"有关“你“的秘密，都在她的心",
            @"icon": @"ni",
            @"type": @"normal"
        }
    ];
    self.noteContent = @[
        @{
            @"title": @"晚安",
            @"detail": @"明天又是新的冒险",
            @"icon": @"wanan",
            @"type": @"normal"
        },
        @{
            @"title": @"这九首歌组成了我的2024",
            @"detail": @"我的最爱音乐没有代餐",
            @"icon": @"anheqiao",
            @"type": @"normal"
        },
        @{
            @"title": @"没了",
            @"detail": @"想不出来了😅",
            @"icon": @"zhou",
            @"type": @"normal"
        }
    ];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)configureNavigationBar {
    UIImage *menuIcon = [UIImage imageNamed:@"caidan"];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:menuIcon style:UIBarButtonItemStylePlain target:self action:@selector(menuTapped)];
    leftItem.tintColor = [UIColor whiteColor];
    
    UIImage *searchIcon = [UIImage imageNamed:@"sousuo"];
    UIBarButtonItem *rightSearch = [[UIBarButtonItem alloc] initWithImage:searchIcon style:UIBarButtonItemStylePlain target:self action:@selector(searchTapped)];
    rightSearch.tintColor = [UIColor whiteColor];
    
    UIImage *moreIcon = [UIImage imageNamed:@"sandian"];
    UIBarButtonItem *rightMore = [[UIBarButtonItem alloc] initWithImage:moreIcon style:UIBarButtonItemStylePlain target:self action:@selector(moreTapped)];
    rightMore.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItems = @[rightMore, rightSearch];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    // 状态栏文本颜色
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return 1;
        case 2: return 1;
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.avatarImageView.image = [UIImage imageNamed:@"avater.jpg"];
            cell.usernameLabel.text = @"A5pkRd";
            cell.vipLabel.text = @"VIP·陆";
            cell.bioLabel.text = @"热爱是一切的理由和答案.";
            cell.statusButton.hidden = NO;
            cell.statsView.hidden = NO;
            return cell;
        }
            
        case 1: {
            ToolbarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToolbarCell" forIndexPath:indexPath];
            cell.menuItems = @[
                @{@"icon": @"zuijin-2", @"title": @"最近"},
                @{@"icon": @"xiazaiwenjianjia-mian", @"title": @"本地"},
                @{@"icon": @"wangpan-2", @"title": @"网盘"},
                @{@"icon": @"duannxiu", @"title": @"装扮"},
                @{@"icon": @"gengduo2", @"title": @"更多"}
            ];
            cell.delegate = self;
            return cell;
        }
            
        case 2: {
            SegmentTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SegmentTabCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.segmentTitles = @[@"音乐", @"播客", @"笔记"];
            cell.selectedIndex = self.selectedSegmentIndex;

            cell.musicContent = self.musicContent;
            cell.podcastContent = self.podcastContent;
            cell.noteContent = self.noteContent;
            
            return cell;
        }
        default:
            return [[UITableViewCell alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 240;
    if (indexPath.section == 1) return 10;
    if (indexPath.section == 2) return 670;
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.1 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)didTapAvatarInCell:(UserInfoCell *)cell {
    
    NSLog(@"代理方法被调用");
    PhotoWallVC *photoVC = [[PhotoWallVC alloc] init];
    photoVC.delegate = self;
    [self presentViewController:photoVC animated:YES completion:nil];
}

- (void)didSelectAvatar:(UIImage *)selectedAvatar {
    NSLog(@"接收到选择的头像");

    self.currentAvatar = selectedAvatar;

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UserInfoCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell setAvatarImageView: _currentAvatar];
}

-(void) menuTapped {
    SettingViewController *settingView = [[SettingViewController alloc] init];
        
        settingView.modalPresentationStyle = UIModalPresentationOverFullScreen;
        settingView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:settingView animated:YES completion:nil];
}

-(void) searchTapped {
    SettingViewController *settingView = [[SettingViewController alloc] init];
        
        settingView.modalPresentationStyle = UIModalPresentationOverFullScreen;
        settingView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:settingView animated:YES completion:nil];
}

-(void) moreTapped {
    SettingViewController *settingView = [[SettingViewController alloc] init];
        
        settingView.modalPresentationStyle = UIModalPresentationOverFullScreen;
        settingView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:settingView animated:YES completion:nil];
}


@end

