//
//  UserInfoCell.h
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/20.
//
#import <UIKit/UIKit.h>
@class UserInfoCell;

@protocol UserInfoCellDelegate <NSObject>
- (void)didTapAvatarInCell:(UserInfoCell *)cell;
@end


@interface UserInfoCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *vipLabel;
@property (nonatomic, strong) UILabel *bioLabel;
@property (nonatomic, strong) UIButton *statusButton;
@property (nonatomic, strong) UIView *statsView;
@property (nonatomic, strong) UIView *badgeView;
@property (nonatomic, weak) id<UserInfoCellDelegate> delegate;
@end
