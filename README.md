# UIStackViewMaker

----------------

Fast API to make a UIStackView instance.

#### Multilingual translation

[Chinese README](README.zh.md)

#### Main Features

* Chain programming API
* Provide a easy way to config UIStackView property
* More conveniently reload or update arraged views
* Immediately reverse arraged views's order

#### Requirements

* iOS 9.0+
* macOS 10.11+

#### Effects

![Demo](./Demo.gif)

#### Installation

##### CocoaPods

The preferred installation method is with [CocoaPods](https://cocoapods.org). Add the following to your `Podfile`:

```ruby
pod 'UIStackViewMaker'
```

##### Manual

Copy UIStackViewMaker directory in your project


#### Getting Started

```objective-c
#import <UIStackViewMaker/UIStackView+STMaker.h>

...

UIStackView * contentStackView = [UIStackView.stMake stConfig:^(STStackViewConfig * _Nonnull config) {
    config.stVer.stDistributeFill.stAlignLead.stInsets(UIEdgeInsetsMake(5, 0, 0, 0));
}];
[contentStackView stGroupItems:^(STStackItemMaker * _Nonnull make) {
    make.stView(self.nameLabel).stTrailSpacing(5);
    make.stView(self.messageLabel);
}];
```

#### License

`UIStackViewMaker` is [MIT-licensed](https://raw.githubusercontent.com/zxinsunshine/UIStackViewMaker/main/LICENSE).

