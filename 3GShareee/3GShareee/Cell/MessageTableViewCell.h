//
//  MessageTableViewCell.h
//  3GShareee
//
//  Created by 吴桐 on 2025/8/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageTableViewCell : UITableViewCell

-(void) configureWithText:(NSString *)text isOutgoing:(BOOL)isOutgoing;

@end

NS_ASSUME_NONNULL_END
