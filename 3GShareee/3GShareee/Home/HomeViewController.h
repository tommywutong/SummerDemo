//
//  FirstVC.h
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//

#import <UIKit/UIKit.h>
#import "TextTableViewCell.h"
#import "HolidayDetailViewController.h"

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, TextTableViewCellDelegate, HolidayDetailViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;

@end
