//
//  MessageViewController.h
//  3GShareee
//
//  Created by 吴桐 on 2025/7/19.
//
#import <UIKit/UIKit.h>

@interface Message : NSObject
@property (nonatomic, copy) NSString *senderName;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *timeAgo;
@property (nonatomic, copy) NSString *avatarName;
@property (nonatomic, assign) BOOL isUnread;
@end

@interface MessageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<Message *> *messages;

@end
