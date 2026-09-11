//
//  AddViewController.m
//  天气难报
//
//  Created by 吴桐 on 2025/7/23.
//

#import "AddViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WEATHER_API_KEY @"2db0265c1d084416b9275428252207"
#import "SearchTableViewCell.h"
#import "DetailViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"请输入您要搜索的城市";
    self.searchBar.frame = CGRectMake(0, 0, WIDTH, 66);
    self.searchBar.alpha = 0.60;
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    //不然会挡住
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 66, WIDTH, HEIGHT - 66);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = YES;
    [self.view addSubview: self.tableView];
    [self.tableView registerClass: [SearchTableViewCell class] forCellReuseIdentifier: @"search"];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.searchResults = @[];
        //self.searchResults = [[NSArray alloc] init];
        [self.tableView reloadData];
        return;
    }
    [self searchCitiesWithKeyword:searchText];
}

//// 点击搜索按钮（键盘上的“Search”）
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"用户搜索: %@", searchBar.text);
//    [searchBar resignFirstResponder]; // 收起键盘
//}
//
//// 文本改变时
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    NSLog(@"搜索内容变了: %@", searchText);
//}
//
//// 开始编辑
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    NSLog(@"开始输入");
//}
//
//// 结束编辑
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//    NSLog(@"结束输入");
//}

-(void) searchBarSearchButtonClicked:(UISearchBar*)searchBar {
    [searchBar resignFirstResponder];
    /*
     这段代码让UISearchBar放弃第一响应者，也就是收起键盘
     但点击搜索按钮时，该段代码触发
     */
    [self searchCitiesWithKeyword:searchBar.text];
}

- (void)searchCitiesWithKeyword:(NSString *)keyword {
    if (keyword.length == 0) {
        return;
    }
    NSString *urlString = [NSString stringWithFormat:
                           @"https://api.weatherapi.com/v1/search.json?key=%@&q=%@&lang=zh&aqi=no",
                           WEATHER_API_KEY, keyword];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]
                                  dataTaskWithURL:url
                                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSError *jsonError;
    NSArray *cities = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    NSMutableArray *results = [NSMutableArray array];
        NSLog(@"%@", cities);
    for (NSDictionary *city in cities) {
        NSString *name = city[@"name"];
        if ([name localizedCaseInsensitiveContainsString:keyword]) {
            [results addObject:city];
        }
    }
    self.searchResults = results;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    }];
    [task resume];
}

-(void) addCityToMain:(NSDictionary *)cityInfo {
    NSString *cityName = cityInfo[@"name"];
    NSDictionary *userInfo = @{@"cityName": cityName};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNewCityNotification" object:nil userInfo:userInfo];
    /*
    //1.只发通知名字
    postNotificationName:@"MyNotification" object:nil;

    //2.附加一个对象（任意类型）
    postNotificationName:@"MyNotification" object:someObject;

    //3.附加一个对象 + userInfo 字典
    postNotificationName:@"MyNotification" object:someObject userInfo:@{@"key": value};
    */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"search" forIndexPath:indexPath];
    if (indexPath.row < self.searchResults.count) {
        NSDictionary *city = self.searchResults[indexPath.row];
        
        NSString* displayText = [NSString stringWithFormat:@"%@, %@", city[@"name"], city[@"region"]];
        cell.textLabel.text = displayText;
    }
    return cell;
}

//选中哪一行就传给主页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.searchResults.count) {
        NSDictionary *city = self.searchResults[indexPath.row];
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        detailVC.cityName = city[@"name"];
        detailVC.canAddCity = YES;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailVC];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
    }
}
- (void)closeDetail {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
