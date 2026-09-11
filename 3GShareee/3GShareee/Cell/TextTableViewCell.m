//
//  textTableViewCell.m
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/16.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(CellTap)];
                [self.contentView addGestureRecognizer:tapGesture];
    }
    return self;
}
// 点击cell任何地方触发
- (void)CellTap {
    if ([self.delegate respondsToSelector:@selector(textTableViewCellDidTap:)]) {
        [self.delegate textTableViewCellDidTap:self];
    }
}

- (void)likeButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSInteger currentCount = [self.likeCountLabel.text integerValue];
    if (sender.selected) {
        currentCount++;
    } else {
        currentCount--;
        
    }
    self.likeCountLabel.text = [NSString stringWithFormat:@"%ld", (long)currentCount];
    if ([self.delegate respondsToSelector:@selector(textTableViewCell:didChangeLikeStatus:newLikeCount:)]) {
            [self.delegate textTableViewCell:self
                          didChangeLikeStatus:sender.selected
                                 newLikeCount:currentCount];
        }
}

- (void)setupUI {
    CGFloat iconSize = 18;
    
    _thumbnailImageView = [[UIImageView alloc] init];
    _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    _thumbnailImageView.clipsToBounds = YES;
    _thumbnailImageView.layer.cornerRadius = 6;
    [self.contentView addSubview:_thumbnailImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 2;
    [self.contentView addSubview:_titleLabel];
    
    _authorLabel = [[UILabel alloc] init];
    _authorLabel.font = [UIFont systemFontOfSize:14];
    _authorLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_authorLabel];
    
    _categoryLabel = [[UILabel alloc] init];
    _categoryLabel.font = [UIFont systemFontOfSize:12];
    _categoryLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_categoryLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_timeLabel];
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeButton setImage:[UIImage imageNamed:@"unliked_icon"] forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@"liked_icon"] forState:UIControlStateSelected];
    [_likeButton addTarget:self action:@selector(likeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_likeButton];
    
    _likeCountLabel = [[UILabel alloc] init];
    _likeCountLabel.font = [UIFont systemFontOfSize:12];
    _likeCountLabel.textColor = [UIColor grayColor];
    _likeCountLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_likeCountLabel];

    _likeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _likeButton.adjustsImageWhenHighlighted = NO;
    _likeButton.imageEdgeInsets = UIEdgeInsetsZero;
    
    
    _viewIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"view_icon"]];
    _viewIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_viewIcon];
    
    _shareIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share_icon"]];
    _shareIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_shareIcon];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 15;
    CGFloat thumbnailWidth = 100;
    CGFloat thumbnailHeight = 70;
    
    _thumbnailImageView.frame = CGRectMake(padding, (self.contentView.bounds.size.height - thumbnailHeight) / 2, thumbnailWidth, thumbnailHeight);
    
    CGFloat contentX = CGRectGetMaxX(_thumbnailImageView.frame) + padding;
    CGFloat contentWidth = self.contentView.bounds.size.width - contentX - padding;
    
    _titleLabel.frame = CGRectMake(contentX, padding, contentWidth, 24);
    _authorLabel.frame = CGRectMake(contentX, CGRectGetMaxY(_titleLabel.frame) + 5, contentWidth, 18);
    _categoryLabel.frame = CGRectMake(contentX, CGRectGetMaxY(_authorLabel.frame) + 2, contentWidth * 0.7, 16);
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_categoryLabel.frame) + 5, CGRectGetMaxY(_authorLabel.frame) + 2, contentWidth * 0.3, 16);
    
    CGFloat statsY = CGRectGetMaxY(_categoryLabel.frame) + 8;
    CGFloat iconSize = 18;
    CGFloat spacing = 10;
        
    _likeButton.frame = CGRectMake(contentX, statsY, iconSize, iconSize);
    _likeCountLabel.frame = CGRectMake(CGRectGetMaxX(_likeButton.frame) + 2, statsY, 30, iconSize);

    _viewIcon.frame = CGRectMake(CGRectGetMaxX(_likeCountLabel.frame) + spacing, statsY, iconSize, iconSize);
    _shareIcon.frame = CGRectMake(CGRectGetMaxX(_viewIcon.frame) + spacing, statsY, iconSize, iconSize);
}

- (void)configureCellWithThumbnail:(UIImage *)thumbnail
                             title:(NSString *)title
                            author:(NSString *)author
                          category:(NSString *)category
                              time:(NSString *)time
                          isLiked:(BOOL)isLiked
                         likeCount:(NSInteger)likeCount
{
    _thumbnailImageView.image = thumbnail;
    _titleLabel.text = title;
    _authorLabel.text = [NSString stringWithFormat:@"SHARE %@", author];
    _categoryLabel.text = category;
    _timeLabel.text = [NSString stringWithFormat:@"%@分钟前", time];
    
    _likeButton.selected = isLiked;
    _likeCountLabel.text = [NSString stringWithFormat:@"%ld", (long)likeCount];
    [self.likeButton addTarget:self action:@selector(likeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

@end
