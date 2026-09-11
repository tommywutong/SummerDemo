//
//  messageSetViewController.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/18.
//

#import "MessageSetViewController.h"
#import "ChatViewController.h"
#import "FollowViewController.h"
@interface MessageSetViewController ()

@end

@implementation MessageSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"消息设置";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize: 26];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"holidayfanhui.png"] style: UIBarButtonItemStylePlain target: self action: @selector(pressReturn)];
    self.navigationItem.leftBarButtonItem = btn;
    btn.tintColor = [UIColor whiteColor];
    
    self.title = @"消息设置";
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    _switchStates = [NSMutableDictionary dictionary];

    _settingsItems = @[
        @{@"title": @"接受新消息通知", @"icon": @"bell"},
        @{@"title": @"通知显示栏", @"icon": @"message"},
        @{@"title": @"声音", @"icon": @"speaker"},
        @{@"title": @"震动", @"icon": @"waveform"},
        @{@"title": @"关注更新", @"icon": @"star"}
    ];

    for (NSDictionary *item in _settingsItems) {
        [_switchStates setObject:@(YES) forKey:item[@"title"]];
    }

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}

- (void)pressReturn {
    [self.navigationController popViewControllerAnimated: YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingsItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MessageSettingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        UIButton *switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        switchButton.frame = CGRectMake(0, 0, 24, 24);
        switchButton.tag = 100 + indexPath.row;
        [switchButton addTarget:self action:@selector(switchButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *title = self.settingsItems[indexPath.row][@"title"];
        BOOL isOn = [self.switchStates[title] boolValue];
        UIImage *onImage = [UIImage imageNamed:@"yes"];
        UIImage *offImage = [UIImage imageNamed:@"no"];
        
        [switchButton setImage:isOn ? onImage : offImage forState:UIControlStateNormal];
        switchButton.tintColor = isOn ? [UIColor colorWithRed:0.1 green:0.5 blue:0.9 alpha:1.0] : [UIColor grayColor];
        
        cell.accessoryView = switchButton;
    }
    NSDictionary *item = self.settingsItems[indexPath.row];
    cell.textLabel.text = item[@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    UIImage *icon = [UIImage systemImageNamed:item[@"icon"]];
    if (icon) {
        icon = [icon imageWithTintColor:[UIColor colorWithRed:0.1 green:0.5 blue:0.9 alpha:1.0]];
        cell.imageView.image = icon;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)switchButtonTapped:(UIButton *)sender {
    NSInteger index = sender.tag - 100;
    NSString *title = self.settingsItems[index][@"title"];

    BOOL currentState = [self.switchStates[title] boolValue];
    BOOL newState = !currentState;
    self.switchStates[title] = @(newState);
    
    UIImage *image = newState ? [UIImage imageNamed:@"yes"] : [UIImage imageNamed:@"no"];
    UIColor *color = newState ? [UIColor colorWithRed:0.1 green:0.5 blue:0.9 alpha:1.0] : [UIColor grayColor];
    
    [sender setImage:image forState:UIControlStateNormal];
    sender.tintColor = color;
    
}

@end
