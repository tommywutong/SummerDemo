//
//  MessageTableViewCell.m
//  3GShareee
//
//  Created by 吴桐 on 2025/8/28.
//

#import "MessageTableViewCell.h"

@interface MessageTableViewCell ()
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIView *bubbleView;
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        _avatarView = [[UIImageView alloc] init];
        _avatarView.layer.cornerRadius = 20;
        _avatarView.layer.masksToBounds = YES;
        [self.contentView addSubview:_avatarView];
        
        _bubbleView = [[UIView alloc] init];
        _bubbleView.layer.cornerRadius = 8;
        _bubbleView.layer.masksToBounds = YES;
        [self.contentView addSubview:_bubbleView];
        
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.numberOfLines = 0;
        [_bubbleView addSubview:_messageLabel];
    }
    return self;
}

- (void)configureWithText:(NSString *)text isOutgoing:(BOOL)isOutgoing {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(screenWidth * 0.6, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attr
                                         context:nil].size;
    
    CGFloat bubbleWidth = textSize.width + 30;
    CGFloat bubbleHeight = textSize.height + 20;
    
    if (isOutgoing) {
        self.avatarView.frame = CGRectMake(screenWidth - 50, 10, 40, 40);
        self.avatarView.image = [UIImage imageNamed:@"IIU.jpg"];
        self.bubbleView.frame = CGRectMake(screenWidth - bubbleWidth - 60, 15, bubbleWidth, bubbleHeight);
        self.bubbleView.backgroundColor = [UIColor colorWithRed:0.0 green:0.48 blue:1.0 alpha:1.0];
        self.messageLabel.textColor = [UIColor whiteColor];
    } else {
        self.avatarView.frame = CGRectMake(10, 10, 40, 40);
        self.avatarView.image = [UIImage imageNamed:@"sixin_img1.png"];
        self.bubbleView.frame = CGRectMake(60, 15, bubbleWidth, bubbleHeight);
        self.bubbleView.backgroundColor = [UIColor whiteColor];
        self.messageLabel.textColor = [UIColor blackColor];
    }
    
    self.messageLabel.frame = CGRectMake(10, 10, textSize.width, textSize.height);
    self.messageLabel.text = text;
}
@end
