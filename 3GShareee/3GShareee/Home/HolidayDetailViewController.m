//
//  HolidayDetailViewController.m
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/16.
//

#import "HolidayDetailViewController.h"
#import "HolidayDetailTableViewCell.h"
#import "TextTableViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

@implementation HolidayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"假日";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉分隔线
    [self.view addSubview:self.tableView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"holidayfanhui.png"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(pressReturn)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self.tableView registerClass:[TextTableViewCell class] forCellReuseIdentifier:@"textMode"];
    [self.tableView registerClass:[HolidayDetailTableViewCell class] forCellReuseIdentifier:@"photoMode"];
    self.isLiked = [self.holidayData[@"isLiked"] boolValue];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    } else {
        return 1600;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textMode" forIndexPath:indexPath];
        
        UIImage *thumbnail = [UIImage imageNamed:self.holidayData[@"thumbnail"]];
        NSString *title = self.holidayData[@"title"];
        NSString *author = self.holidayData[@"author"];
        NSString *category = self.holidayData[@"category"];
        NSString *time = self.holidayData[@"time"];
        BOOL isLiked = self.isLiked;
        NSInteger likeCount = [self.holidayData[@"likeCount"] integerValue];

        [cell configureCellWithThumbnail:thumbnail
                                   title:title
                                  author:author
                                category:category
                                    time:time
                                isLiked:isLiked
                               likeCount:likeCount];
        cell.delegate = self;
        return cell;
    } else {
        HolidayDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoMode" forIndexPath:indexPath];
        return cell;
    }
}

- (void)pressReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textTableViewCell:(TextTableViewCell *)cell
       didChangeLikeStatus:(BOOL)isLiked
              newLikeCount:(NSInteger)likeCount
{
    self.isLiked = isLiked;
    self.holidayData[@"isLiked"] = @(isLiked);
    self.holidayData[@"likeCount"] = @(likeCount);
    //下面的if判断，用来判断HomeVC是否实现了这个方法，不让就不传
    //确保程序不会崩溃
    if ([self.delegate respondsToSelector:@selector(holidayDetail:didChangeLikeStatus:newLikeCount:)]) {
        [self.delegate holidayDetail:self
                didChangeLikeStatus:isLiked
                       newLikeCount:likeCount];
    }
}

@end
