//
//  STTableViewCell.h
//  UIStackViewMakerDemo
//
//  Created by Theo on 2022/9/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isSender;
@property (nonatomic, copy) NSString * message;

@end

NS_ASSUME_NONNULL_END
