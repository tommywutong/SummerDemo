//
//  FourthVC.m
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//

#import "ActivityViewController.h"
#import "PosterTableViewCell.h"

@interface ActivityViewController ()
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设计活动";
    self.view.backgroundColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    /*
     下面两行分别为去掉分割线和去掉滚动条
     */
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[PosterTableViewCell class] forCellReuseIdentifier:@"SimpleCell"];
    [self.view addSubview:_tableView];
    
    [self createData];
}

- (void)createData {
    self.dataArray = @[
        @{
            @"image": @"poster1",
            @"text": @"下厨也要美美哒，从一条围裙开始"
        },
        @{
            @"image": @"poster2",
            @"text": @"MIUI主题市场让你的创意改变世界!"
        },
        @{
            @"image": @"poster3",
            @"text": @"HUAWEI赛 华为花粉吉祥物设计大赛"
        }
    ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PosterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleCell" forIndexPath:indexPath];
    NSDictionary *data = self.dataArray[indexPath.row];
    NSString *imageName = data[@"image"];
    NSString *text = data[@"text"];
    UIImage *image = [UIImage imageNamed:imageName];
    if (!image) {
        image = [UIImage systemImageNamed:@"photo"];
    }
    [cell configureCellWithImage:image text:text];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180 + 50 + 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
