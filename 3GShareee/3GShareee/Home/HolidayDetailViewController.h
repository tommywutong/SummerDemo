//
//  HolidayDetailViewController.h
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/16.
//

#import <UIKit/UIKit.h>
#import "TextTableViewCell.h"
@protocol HolidayDetailViewControllerDelegate;


@interface HolidayDetailViewController : UIViewController <TextTableViewCellDelegate>

@property (nonatomic, strong) NSMutableDictionary *holidayData;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *likeIcon;
@property (nonatomic, assign) BOOL isLiked;
@property (nonatomic, weak) id<HolidayDetailViewControllerDelegate> delegate;

@end

@protocol HolidayDetailViewControllerDelegate <NSObject>
- (void)holidayDetail:(HolidayDetailViewController *)detail didChangeLikeStatus:(BOOL)isLiked newLikeCount:(NSInteger)likeCount;

@end
