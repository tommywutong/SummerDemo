//
//  textTableViewCell.h
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/16.
//
#import <UIKit/UIKit.h>

@protocol TextTableViewCellDelegate;

@interface TextTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIImageView *viewIcon;
@property (nonatomic, strong) UIImageView *shareIcon;
@property (nonatomic, strong) UILabel* likeCountLabel;
@property (nonatomic, assign) NSInteger itemIndex;
@property (nonatomic, weak) id<TextTableViewCellDelegate> delegate;

- (void)configureCellWithThumbnail:(UIImage *)thumbnail
                             title:(NSString *)title
                            author:(NSString *)author
                          category:(NSString *)category
                              time:(NSString *)time
                          isLiked:(BOOL)isLiked
                        likeCount:(NSInteger)likeCount;

@end

@protocol TextTableViewCellDelegate <NSObject>
/*
 为什么不用didselectCellatIndex?
 因为我想实现的是单个点赞按钮的点击，用自带函数只能实现整行的点赞
 */
- (void)textTableViewCellDidTap:(TextTableViewCell *)cell;
- (void)textTableViewCell:(TextTableViewCell *)cell
     didChangeLikeStatus:(BOOL)isLiked
            newLikeCount:(NSInteger)likeCount;
@end
