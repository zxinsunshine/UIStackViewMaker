//
//  UIStackView+STMaker.m
//  Test
//
//  Created by Theo on 2022/5/19.
//

#import "UIStackView+STMaker.h"
#import <objc/runtime.h>

static const char * kIsArrangeReverseKey = "kIsArrangeReverseKey";

// ####################################################################
static const CGFloat kItemTrailSpaceNone = -1;
@interface STStackItem()

@property (nonatomic, strong) UIView * itemView;
@property (nonatomic, assign) CGFloat itemTrailSpace;

@end

@implementation STStackItem

- (STStackItem *(^)(CGFloat space))stTrailSpacing {
    return ^(CGFloat space){
        if (space >= 0) {
            self.itemTrailSpace = space;
        }
        return self;
    };
}

@end

// ####################################################################
@interface STStackItemMaker()

@property (nonatomic, strong) NSMutableArray<STStackItem *> * itemArray;

@end

@implementation STStackItemMaker

- (STStackItem *(^)(UIView * view))stView {
    return ^(UIView * view){
        STStackItem * item = [[STStackItem alloc] init];
        item.itemView = view;
        item.itemTrailSpace = kItemTrailSpaceNone;
        [self.itemArray addObject:item];
        return item;
    };
}

#pragma mark - Private Methods
- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

@end

// ####################################################################
@interface STStackViewConfig()

@property (nonatomic, weak) UIStackView * stackView;

@end

@implementation STStackViewConfig

- (instancetype)initWithStackView:(UIStackView *)stackView
{
    self = [super init];
    if (self) {
        self.stackView = stackView;
    }
    return self;
}

- (STStackViewConfig *)stHor {
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    return self;
}

- (STStackViewConfig *)stVer {
    self.stackView.axis = UILayoutConstraintAxisVertical;
    return self;
}

- (STStackViewConfig *)stAlignLead {
    self.stackView.alignment = UIStackViewAlignmentLeading;
    return self;
}

- (STStackViewConfig *)stAlignTrail {
    self.stackView.alignment = UIStackViewAlignmentTrailing;
    return self;
}

- (STStackViewConfig *)stAlignCenter {
    self.stackView.alignment = UIStackViewAlignmentCenter;
    return self;
}

- (STStackViewConfig *)stAlignFill {
    self.stackView.alignment = UIStackViewAlignmentFill;
    return self;
}

- (STStackViewConfig *)stDistributeFill {
    self.stackView.distribution = UIStackViewDistributionFill;
    return self;
}

- (STStackViewConfig *)stDistributeEqual {
    self.stackView.distribution = UIStackViewDistributionEqualSpacing;
    return self;
}

- (STStackViewConfig *(^)(CGFloat space))stSpacing {
    return ^(CGFloat space){
        self.stackView.spacing = space;
        return self;
    };
}

- (STStackViewConfig *(^)(UIEdgeInsets insets))stInsets {
    return ^(UIEdgeInsets insets){
        if (!UIEdgeInsetsEqualToEdgeInsets(insets, self.stackView.layoutMargins)) {
            self.stackView.layoutMargins = insets;
        }
        self.stackView.layoutMarginsRelativeArrangement = !UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero);
        return self;
    };
}

- (STStackViewConfig *(^)(BOOL reverse))stReverse {
    return ^(BOOL reverse){
        if (self.stackView.arrangedSubviews.count > 0 && reverse != [self.stackView stArrangeReverse]) {
            NSArray<UIView *> *copyArrangedSubviews = [NSArray arrayWithArray:self.stackView.arrangedSubviews];
            [copyArrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.stackView insertArrangedSubview:obj atIndex:0];
            }];
            objc_setAssociatedObject(self.stackView, kIsArrangeReverseKey, @(reverse), OBJC_ASSOCIATION_ASSIGN);
        }
        return self;
    };
}

- (void(^)(void))end {
    return ^{};
}

#pragma mark - Private Methods
- (STStackViewConfig *)stConfigDefault {
    return self.stHor.stDistributeEqual.stAlignLead.stReverse(NO).stSpacing(0);
}


@end

// ####################################################################

@implementation UIStackView (STMaker)

+ (instancetype)stMake {
    UIStackView * stackView = [[UIStackView alloc] init];
    return stackView;
}

- (UIStackView *)stConfig:(void(^)(STStackViewConfig * config))block {
    STStackViewConfig * config = [[STStackViewConfig alloc] initWithStackView:self];
    block([config stConfigDefault]);
    return self;
}

- (UIStackView *)stUpdateConfig:(void(^)(STStackViewConfig * config))block {
    STStackViewConfig * config = [[STStackViewConfig alloc] initWithStackView:self];
    block(config);
    return self;
}

- (UIStackView *)stGroupItems:(void(^)(STStackItemMaker * make))block {
    
    [self removeAllArrangedViews];
    STStackItemMaker * make = [[STStackItemMaker alloc] init];
    block(make);
    [make.itemArray enumerateObjectsUsingBlock:^(STStackItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addArrangedSubview:obj.itemView];
        if (obj.itemTrailSpace != kItemTrailSpaceNone) {
            [self setCustomSpacing:obj.itemTrailSpace afterView:obj.itemView];
        }
    }];
    objc_setAssociatedObject(self, kIsArrangeReverseKey, @(NO), OBJC_ASSOCIATION_ASSIGN);
    return self;
}

- (UIStackView *)stAddGroupItems:(void(^)(STStackItemMaker * make))block {
    
    STStackItemMaker * make = [[STStackItemMaker alloc] init];
    block(make);
    [make.itemArray enumerateObjectsUsingBlock:^(STStackItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addArrangedSubview:obj.itemView];
        if (obj.itemTrailSpace != kItemTrailSpaceNone) {
            [self setCustomSpacing:obj.itemTrailSpace afterView:obj.itemView];
        }
    }];
    return self;
}

#pragma mark - Private Methods
- (void)removeAllArrangedViews {
    [self.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

- (BOOL)stArrangeReverse {
    return [objc_getAssociatedObject(self, kIsArrangeReverseKey) boolValue];
}

@end
