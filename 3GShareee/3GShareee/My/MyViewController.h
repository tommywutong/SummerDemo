//
//  FifthVC.h
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *roleLabel;
@property (nonatomic, strong) UILabel *signatureLabel;

@end
