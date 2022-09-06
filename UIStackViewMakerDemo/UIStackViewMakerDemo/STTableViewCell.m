//
//  STTableViewCell.m
//  UIStackViewMakerDemo
//
//  Created by Theo on 2022/9/6.
//

#import "STTableViewCell.h"
#import <UIStackViewMaker/UIStackView+STMaker.h>

static const CGFloat kAvatarWH = 50;

@interface STTableViewCell()
// layout view
@property (nonatomic, strong) UIStackView * alignStackView;
@property (nonatomic, strong) UIStackView * lineStackView;
@property (nonatomic, strong) UIStackView * contentStackView;

// item view
@property (nonatomic, strong) UIImageView * avatarView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * messageLabel;

@end

@implementation STTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.avatarView = ({
        UIImageView * view = [[UIImageView alloc] init];
        view.layer.cornerRadius = kAvatarWH / 2;
        view.clipsToBounds = YES;
        view;
    });
    
    self.nameLabel = ({
        UILabel * label = [[UILabel alloc] init];
        label.textColor = [UIColor colorWithWhite:0 alpha:0.8];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:12];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 1;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label;
    });
    
    self.messageLabel = ({
        UILabel * label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        label;
    });
    self.contentStackView = [[UIStackView.stMake stConfig:^(STStackViewConfig * _Nonnull config) {
        config.stVer.stDistributeFill.stAlignLead.stInsets(UIEdgeInsetsMake(5, 0, 0, 0));
    }] stGroupItems:^(STStackItemMaker * _Nonnull make) {
        make.stView(self.nameLabel).stTrailSpacing(5);
        make.stView(self.messageLabel);
    }];
    self.lineStackView = [[UIStackView.stMake stConfig:^(STStackViewConfig * _Nonnull config) {
        config.stHor.stDistributeFill.stAlignLead.end();
    }] stGroupItems:^(STStackItemMaker * _Nonnull make) {
        make.stView(self.avatarView).stTrailSpacing(5);
        make.stView(self.contentStackView).stTrailSpacing(5);
    }];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kAvatarWH, kAvatarWH));
    }];
    [self.contentStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(300);
    }];
    self.alignStackView = [[UIStackView.stMake stConfig:^(STStackViewConfig * _Nonnull config) {
        config.stVer.stDistributeFill.stAlignLead.end();
    }] stGroupItems:^(STStackItemMaker * _Nonnull make) {
        make.stView(self.lineStackView);
    }];
   
    UIView * superView = self.contentView;
    [superView addSubview:self.alignStackView];
    [self.alignStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.messageLabel.text = message;
}

- (void)setIsSender:(BOOL)isSender {
    _isSender = isSender;
    
    [self.alignStackView stUpdateConfig:^(STStackViewConfig * _Nonnull config) {
        if (isSender) {
            config.stAlignTrail.end();
        } else {
            config.stAlignLead.end();
        }
    }];
    [self.lineStackView stUpdateConfig:^(STStackViewConfig * _Nonnull config) {
        config.stReverse(isSender);
    }];
    [self.contentStackView stUpdateConfig:^(STStackViewConfig * _Nonnull config) {
        if (isSender) {
            config.stAlignTrail.end();
        } else {
            config.stAlignLead.end();
        }
    }];
    
    self.avatarView.backgroundColor = isSender ? [UIColor blueColor] : [UIColor redColor];
    self.nameLabel.text = isSender ? @"发送者:我" : @"发送者:TA";
}

@end
