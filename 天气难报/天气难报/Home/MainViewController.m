//
//  MainViewController.m
//  天气难报
//
//  Created by 吴桐 on 2025/7/23.
//

#import "MainViewController.h"
#import "AddViewController.h"
#import "TextTableViewCell.h"
#import "CitiesDetailViewController.h"
#import "DetailViewController.h"
#import "NetworkManager.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)AddViewController* addViewController;
@property (nonatomic, strong)DetailViewController* detailViewController;
@property (nonatomic, strong)NSMutableArray* tempData;
@property (nonatomic, strong)NSMutableArray* cityData;
@property (nonatomic, strong)NSMutableArray* weatherimgData;
@property (nonatomic, strong)UITableView* tableView;

@property (nonatomic, strong)NSMutableArray* dicArray;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"tianjia.png"] style: UIBarButtonItemStylePlain target: self action: @selector(pressAdd)];
    addButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = addButton;
    
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(WIDTH / 2 - 183, 0, 366, HEIGHT) style: UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview: self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass: [TextTableViewCell class] forCellReuseIdentifier: @"main"];
    self.tableView.showsVerticalScrollIndicator = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notice:) name:@"1" object:nil];
    
    self.cityData = [@[
           @{@"name": @"北京"},
           @{@"name": @"成都"},
           @{@"name": @"西安"},
           @{@"name": @"海南"}
       ] mutableCopy];
    self.tempData = [[NSMutableArray alloc] init];
    self.weatherimgData = [[NSMutableArray alloc] init];
    self.dicArray = [[NSMutableArray alloc] init];
    [self createUrl];
//    UIImage *img = [UIImage imageNamed:@"weather1.jpg"];
//    NSLog(@"%@", img);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleAddCityNotification:)
                                                     name:@"AddNewCityNotification"
                                                   object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                    selector:@selector(handleDeleteCityNotification:)
                                                        name:@"DeleteCityNotification"
                                                      object:nil];
}

-(void) handleAddCityNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *newCity = userInfo[@"cityName"];
    BOOL exists = NO;
    for (NSDictionary *city in self.cityData) {
        if ([city[@"name"] isEqualToString:newCity]) {
            exists = YES;
            break;
        }
    }
    if (!exists) {
        [self.cityData addObject:@{@"name": newCity}];
        [self createUrl];
    }
}

- (void)handleDeleteCityNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *cityName = userInfo[@"cityName"];
    NSMutableArray *citiesToRemove = [NSMutableArray array];
    for (NSDictionary *city in self.cityData) {
        if ([city[@"name"] isEqualToString:cityName]) {
            [citiesToRemove addObject:city];
        }
    }
    [self.cityData removeObjectsInArray:citiesToRemove];
//    [self createUrl];
//    [self saveCities];
    [self.tableView reloadData];
}

/*
 保存到本地
 */
- (void)saveCities {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.cityData forKey:@"SavedCities"];
    [defaults synchronize];
}
- (void)loadCities {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *savedCities = [defaults objectForKey:@"SavedCities"];
    if (savedCities) {
        self.cityData = [savedCities mutableCopy];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"main" forIndexPath:indexPath];
    if (indexPath.section < self.dicArray.count) {
        NSDictionary* weatherData = self.dicArray[indexPath.section];
        NSDictionary *current = weatherData[@"current"];
        NSDictionary *condition = current[@"condition"];
        NSString *iconURL = condition[@"icon"];
        NSString *cityName = self.cityData[indexPath.section][@"name"];
        NSString *temp = current[@"temp_c"];
        [cell configureWithCity:cityName
                          temp:[NSString stringWithFormat:@"%@℃", temp]
               weatherIconURL:iconURL
                 conditionCode:[condition[@"code"] integerValue]];
    }
    return cell;
}
-(void) pressAdd {
    self.addViewController = [[AddViewController alloc] init];
    self.addViewController.cityData = self.cityData;
    self.addViewController.tempData = self.tempData;
    self.addViewController.weatherimgData = self.weatherimgData;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.addViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableArray *cityNames = [NSMutableArray array];
    for (NSDictionary *city in self.cityData) {
        [cityNames addObject:city[@"name"]];
    }
    CitiesDetailViewController *containerVC = [[CitiesDetailViewController alloc] init];
    containerVC.cityNames = cityNames;
    containerVC.initialIndex = indexPath.section;
    containerVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:containerVC animated:YES completion:nil];
}

- (void)createUrl {
    if (self.cityData.count == 0) return;
    NSMutableArray *tempDicArray = [NSMutableArray array];
    for (NSDictionary *city in self.cityData) {
        NSString *cityName = city[@"name"];
        [[NetworkManager sharedManager] fetchCityWeather:cityName completion:^(NSDictionary * _Nullable weatherData, NSError * _Nullable error) {
            if (error) {
                NSLog(@"获取天气数据失败: %@", error.localizedDescription);
                return;
            }
            
            if (weatherData) {
                NSLog(@"%@", weatherData);
                @synchronized (tempDicArray) {
                    [tempDicArray addObject:weatherData];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.dicArray = [tempDicArray copy];
                    [self.tableView reloadData];
                });
            }
        }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)notice:(NSNotification *)sender {
    self.cityData = [sender.userInfo[@"cityData"] mutableCopy];
    [self createUrl];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// 添加支持滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        /*
         要确保是可变数组，不然程序会报错
         */
        self.cityData = [self.cityData mutableCopy];
        self.dicArray = [self.dicArray mutableCopy];
        [self.cityData removeObjectAtIndex:indexPath.section];
        if (indexPath.section < self.dicArray.count) {
            [self.dicArray removeObjectAtIndex:indexPath.section];
        }
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                 withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
