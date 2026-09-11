//
//  FirstTableViewCell.h
//  网易云音乐
//
//  Created by 吴桐 on 2025/7/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstTableViewCell : UITableViewCell
@property (nonatomic,strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSTimer *timer;
- (void)configureWithSongTitle:(NSString *)title albumInfo:(NSString *)info imageName:(NSString *)imageName;

@property (nonatomic, strong) UIScrollView* scrollView02;
@property (nonatomic, strong)UILabel* label02;
@property (nonatomic, strong)UILabel* label2;

@property (nonatomic, strong) UIScrollView* scrollView03;
@property (nonatomic, strong) UILabel* label03;
@property (nonatomic, strong)UITableView* tableView03;
@property (nonatomic, strong)UITableView* tableView0301;
@property (nonatomic, strong)UITableView* tableView0302;
@property (nonatomic, strong)UITableView* tableView0303;
@end

NS_ASSUME_NONNULL_END
