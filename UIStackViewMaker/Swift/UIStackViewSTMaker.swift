//
//  UIStackViewSTMaker.swift
//  UIStackViewMaker
//
//  Created by Theo on 2024/6/21.
//

import UIKit
import ObjectiveC  // 导入 Objective-C 运行时库

private var kIsArrangeReverseKey: UInt8 = 0
private let kItemTrailSpaceDefault: CGFloat = -1

@objcMembers
public final class STStackItem: NSObject {
    let itemView: UIView
    var itemTrailSpace: CGFloat = kItemTrailSpaceDefault
    
    init(itemView: UIView) {
        self.itemView = itemView
    }
    
    public var stTrailSpacing:(_ space: CGFloat) -> STStackItem {
        get {
            stTrailSpacing(_:)
        }
    }
    @discardableResult
    private func stTrailSpacing(_ space: CGFloat) -> STStackItem {
        if space >= 0 {
            self.itemTrailSpace = space
        }
        return self
    }
    
    @discardableResult
    public func end() -> () -> Void {
        {}
    }
}

@objcMembers
public final class STStackItemMaker: NSObject {
    var itemArray: [STStackItem] {
        return items
    }
    private var items = [STStackItem]()
    
    public var stView:(_ view: UIView) -> STStackItem {
        get {
            stView(_:)
        }
    }
    @discardableResult
    private func stView(_ view: UIView) -> STStackItem {
        let item = STStackItem(itemView: view)
        self.items.append(item)
        return item
    }
}

@objcMembers
public final class STStackViewConfig: NSObject {
    private weak var stackView: UIStackView?
    
    init(stackView: UIStackView) {
        self.stackView = stackView
    }
    
    public func stHor() -> STStackViewConfig {
        self.stackView?.axis = .horizontal
        return self
    }
    
    public func stVer() -> STStackViewConfig {
        self.stackView?.axis = .vertical
        return self
    }
    
    public func stAlignLead() -> STStackViewConfig {
        self.stackView?.alignment = .leading
        return self
    }
    
    public func stAlignTrail() -> STStackViewConfig {
        self.stackView?.alignment = .trailing
        return self
    }
    
    public func stAlignCenter() -> STStackViewConfig {
        self.stackView?.alignment = .center
        return self
    }
    
    public func stAlignFill() -> STStackViewConfig {
        self.stackView?.alignment = .fill
        return self
    }
    
    public func stDistributeFill() -> STStackViewConfig {
        self.stackView?.distribution = .fill
        return self
    }
    
    public func stDistributeEqualFill() -> STStackViewConfig {
        self.stackView?.distribution = .fillEqually
        return self
    }
    
    public func stDistributeEqual() -> STStackViewConfig {
        self.stackView?.distribution = .equalSpacing
        return self
    }
    
    public var stSpacing:(_ space: CGFloat) -> STStackViewConfig {
        get {
            stSpacing(_:)
        }
    }
    @discardableResult
    private func stSpacing(_ space: CGFloat) -> STStackViewConfig {
        self.stackView?.spacing = space
        return self
    }
    
    public var stInsets:(_ insets: UIEdgeInsets) -> STStackViewConfig {
        get {
            stInsets(_:)
        }
    }
    @discardableResult
    private func stInsets(_ insets: UIEdgeInsets) -> STStackViewConfig {
        if insets != self.stackView?.layoutMargins {
            self.stackView?.layoutMargins = insets
        }
        self.stackView?.isLayoutMarginsRelativeArrangement = insets != .zero
        return self
    }
    
    
    public var stReverse:(_ reverse: Bool) -> STStackViewConfig {
        get {
            stReverse(_:)
        }
    }
    @discardableResult
    private func stReverse(_ reverse: Bool) -> STStackViewConfig {
        guard let stackView = self.stackView else { return self }
        if stackView.arrangedSubviews.count > 0 && reverse != stackView.stArrangeReverse() {
            let copyArrangedSubviews = stackView.arrangedSubviews
            copyArrangedSubviews.forEach { stackView.insertArrangedSubview($0, at: 0) }
            objc_setAssociatedObject(stackView, &kIsArrangeReverseKey, reverse, .OBJC_ASSOCIATION_ASSIGN)
        }
        return self
    }
    
    @discardableResult
    public func end() -> () -> Void {
        {}
    }
    
    public func stConfigDefault() -> STStackViewConfig {
        return self.stHor().stDistributeEqual().stAlignLead().stReverse(false).stSpacing(0)
    }
}

public extension UIStackView {
    @objc class func stMake() -> UIStackView {
        return UIStackView()
    }
    
    @discardableResult
    @objc func stConfig(_ block: (STStackViewConfig) -> Void) -> UIStackView {
        let config = STStackViewConfig(stackView: self)
        block(config.stConfigDefault())
        return self
    }
    
    @discardableResult
    @objc func stUpdateConfig(_ block: (STStackViewConfig) -> Void) -> UIStackView {
        let config = STStackViewConfig(stackView: self)
        block(config)
        return self
    }
    
    @discardableResult
    @objc func stGroupItems(_ block: (STStackItemMaker) -> Void) -> UIStackView {
        self.removeAllArrangedSubviews()
        let make = STStackItemMaker()
        block(make)
        make.itemArray.forEach {
            self.addArrangedSubview($0.itemView)
            if ($0.itemTrailSpace != kItemTrailSpaceDefault) {
                self.setCustomSpacing($0.itemTrailSpace, after: $0.itemView)
            }
        }
        objc_setAssociatedObject(self, &kIsArrangeReverseKey, false, .OBJC_ASSOCIATION_ASSIGN);
        return self
    }
    
    @discardableResult
    @objc func stAddGroupItems(_ block: (STStackItemMaker) -> Void) -> UIStackView {
        let make = STStackItemMaker()
        block(make)
        make.itemArray.forEach {
            self.addArrangedSubview($0.itemView)
            if ($0.itemTrailSpace != kItemTrailSpaceDefault) {
                self.setCustomSpacing($0.itemTrailSpace, after: $0.itemView)
            }
        }
        return self
    }
    
    @discardableResult
    fileprivate func stArrangeReverse() -> Bool {
        return objc_getAssociatedObject(self, &kIsArrangeReverseKey) as? Bool ?? false
    }
    
    private func removeAllArrangedSubviews() {
        self.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
