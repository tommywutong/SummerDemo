//
//  followViewController.h
//  3GShareee
//
//  Created by 吴桐 on 2025/7/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FollowViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSMutableDictionary *followingStatus;
@property (nonatomic, strong) NSArray *avatars;

@end


NS_ASSUME_NONNULL_END
