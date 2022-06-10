//
//  UIStackView+STMaker.h
//  Test
//
//  Created by Theo on 2022/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// ####################################################################
@interface STStackItem : NSObject

- (STStackItem *(^)(CGFloat space))stTrailSpacing; // arranged view trail space

@end

// ####################################################################
@interface STStackItemMaker : NSObject

- (STStackItem *(^)(UIView * view))stView; // append arranged view

@end

// ####################################################################
@interface STStackViewConfig : NSObject

- (STStackViewConfig *)stHor;

- (STStackViewConfig *)stVer;

- (STStackViewConfig *)stAlignLead;

- (STStackViewConfig *)stAlignTrail;

- (STStackViewConfig *)stAlignCenter;

- (STStackViewConfig *)stAlignFill;

- (STStackViewConfig *)stDistributeFill;

- (STStackViewConfig *)stDistributeEqual;

- (STStackViewConfig *(^)(CGFloat space))stSpacing;

- (STStackViewConfig *(^)(UIEdgeInsets insets))stInsets;

- (STStackViewConfig *(^)(BOOL reverse))stReverse; // reverse sort

- (void(^)(void))end;

@end


// ####################################################################
@interface UIStackView (STMaker)

+ (instancetype)stMake;

- (UIStackView *)stConfig:(void(^)(STStackViewConfig * config))block; // reset config of stack view

- (UIStackView *)stUpdateConfig:(void(^)(STStackViewConfig * config))block; // update config of stack view

- (UIStackView *)stGroupItems:(void(^)(STStackItemMaker * make))block; // group arranged views

- (UIStackView *)stAddGroupItems:(void(^)(STStackItemMaker * make))block; // add group arranged views

- (BOOL)stArrangeReverse;

@end

NS_ASSUME_NONNULL_END
