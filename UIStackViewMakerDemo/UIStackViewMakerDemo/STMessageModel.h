//
//  STMessageModel.h
//  UIStackViewMakerDemo
//
//  Created by Theo on 2022/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STMessageModel : NSObject

@property (nonatomic, assign) BOOL isSender;
@property (nonatomic, copy) NSString * message;

@end

NS_ASSUME_NONNULL_END
