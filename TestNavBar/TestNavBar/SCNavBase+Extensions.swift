//
//  SCNavBase+Extensions.swift
//  TestNavBar
//
//  Created by zero on 2019/8/5.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

extension UIViewController: SCNavCompatible {
    var scnav: SCNav<UIViewController> {
        get {
            return SCNav(self)
        }
        set {

        }
    }
}

extension SCNav where Base: UIViewController {
    var bgAlpha: CGFloat {
        get {
            guard let alpha = objc_getAssociatedObject(base, &AssociatedKeys.bgAlpha) as? CGFloat else {
                return SCNavConfig.default.bgAlpha
            }
            return alpha
        }
        set {
            let alpha = max(min(newValue, 1), 0) // 必须在 0~1的范围
            objc_setAssociatedObject(base, &AssociatedKeys.bgAlpha, alpha, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            // Update UI
            base.navigationController?.setNeedsNavigationBackground(alpha: alpha)
        }
    }

    var tintColor: UIColor {
        get {
            guard let color = objc_getAssociatedObject(base, &AssociatedKeys.tintColor) as? UIColor else {
                return SCNavConfig.default.tintColor
            }
            return color
        }
        set {
            objc_setAssociatedObject(base, &AssociatedKeys.tintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            base.navigationController?.navigationBar.tintColor = newValue
        }
    }

    var titleTextAttributes: [NSAttributedString.Key : Any]? {
        get {
            guard let attributes = objc_getAssociatedObject(base, &AssociatedKeys.titleTextAttributes) as? [NSAttributedString.Key : Any] else {
                return SCNavConfig.default.titleTextAttributes
            }
            return attributes
        }
        set {
            objc_setAssociatedObject(base, &AssociatedKeys.titleTextAttributes, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            base.navigationController?.navigationBar.titleTextAttributes = newValue
        }
    }

    var statusBarStyle: UIStatusBarStyle {
        get {
            guard let style = objc_getAssociatedObject(base, &AssociatedKeys.statusBarStyle) as? UIStatusBarStyle else {
                return SCNavConfig.default.statusBarStyle
            }
            return style
        }
        set {
            objc_setAssociatedObject(base, &AssociatedKeys.statusBarStyle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            base.setNeedsStatusBarAppearanceUpdate()
        }
    }

    var hidden: Bool {
        get {
            guard let hidden = objc_getAssociatedObject(base, &AssociatedKeys.hidden) as? Bool else {
                return SCNavConfig.default.hidden
            }
            return hidden
        }
        set {
            objc_setAssociatedObject(base, &AssociatedKeys.hidden, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}



extension UINavigationController {

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    open override func viewDidLoad() {
        UINavigationController.swizzle()
        super.viewDidLoad()
    }

    private static let onceToken = UUID().uuidString

    class func swizzle() {
        guard self == UINavigationController.self else { return }

        DispatchQueue.once(token: onceToken) {
            let needSwizzleSelectorArr = [
                NSSelectorFromString("_updateInteractiveTransition:"),
                #selector(popViewController(animated:)),
                #selector(popToViewController(_:animated:)),
                #selector(popToRootViewController(animated:))
            ]

            for selector in needSwizzleSelectorArr {

                let str = ("et_" + selector.description).replacingOccurrences(of: "__", with: "_")

                let originalMethod = class_getInstanceMethod(self, selector)
                let swizzledMethod = class_getInstanceMethod(self, Selector(str))
                if originalMethod != nil && swizzledMethod != nil {
                    method_exchangeImplementations(originalMethod!, swizzledMethod!)
                }
            }
        }
    }

    @objc func et_updateInteractiveTransition(_ percentComplete: CGFloat) {
        guard let topViewController = topViewController, let coordinator = topViewController.transitionCoordinator else {
            et_updateInteractiveTransition(percentComplete)
            return
        }

        coordinator.notifyWhenInteractionChanges({ (context) in
            self.dealInteractionChanges(context)
        })

        let fromViewController = coordinator.viewController(forKey: .from)
        let toViewController = coordinator.viewController(forKey: .to)

        // Bg Alpha
        let fromAlpha = fromViewController?.scnav.bgAlpha ?? 0
        let toAlpha = toViewController?.scnav.bgAlpha ?? 0
        let newAlpha = fromAlpha + (toAlpha - fromAlpha) * percentComplete

        setNeedsNavigationBackground(alpha: newAlpha)

        // Tint Color
        let fromColor = fromViewController?.scnav.tintColor ?? .blue
        let toColor = toViewController?.scnav.tintColor ?? .blue
        let newColor = averageColor(fromColor: fromColor, toColor: toColor, percent: percentComplete)
        navigationBar.tintColor = newColor
        et_updateInteractiveTransition(percentComplete)
    }

    // Calculate the middle Color with translation percent
    private func averageColor(fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> UIColor {
        var fromRed: CGFloat = 0
        var fromGreen: CGFloat = 0
        var fromBlue: CGFloat = 0
        var fromAlpha: CGFloat = 0
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)

        var toRed: CGFloat = 0
        var toGreen: CGFloat = 0
        var toBlue: CGFloat = 0
        var toAlpha: CGFloat = 0
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)

        let nowRed = fromRed + (toRed - fromRed) * percent
        let nowGreen = fromGreen + (toGreen - fromGreen) * percent
        let nowBlue = fromBlue + (toBlue - fromBlue) * percent
        let nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percent

        return UIColor(red: nowRed, green: nowGreen, blue: nowBlue, alpha: nowAlpha)
    }

    @objc func et_popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        setNeedsNavigationBackground(alpha: viewController.scnav.bgAlpha)
        navigationBar.tintColor = viewController.scnav.tintColor
        navigationBar.titleTextAttributes = viewController.scnav.titleTextAttributes
        return et_popToViewController(viewController, animated: animated)
    }

    @objc func et_popViewControllerAnimated(_ animated: Bool) -> UIViewController? {
        if #available(iOS 13.0, *) {
            if (viewControllers.count > 1 && interactivePopGestureRecognizer?.state != .began){
                let popToVC = viewControllers[viewControllers.count - 2]
                setNeedsNavigationBackground(alpha: popToVC.scnav.bgAlpha)
                navigationBar.tintColor = popToVC.scnav.tintColor
                navigationBar.titleTextAttributes = popToVC.scnav.titleTextAttributes
            }
        }
        return et_popViewControllerAnimated(animated)
    }

    @objc func et_popToRootViewControllerAnimated(_ animated: Bool) -> [UIViewController]? {
        setNeedsNavigationBackground(alpha: viewControllers.first?.scnav.bgAlpha ?? 0)
        navigationBar.tintColor = viewControllers.first?.scnav.tintColor
        navigationBar.titleTextAttributes = viewControllers.first?.scnav.titleTextAttributes
        return et_popToRootViewControllerAnimated(animated)
    }

    fileprivate func setNeedsNavigationBackground(alpha: CGFloat) {
        if let barBackgroundView = navigationBar.subviews.first {
            let valueForKey = barBackgroundView.getIvar(forKey:)

            if let shadowView = valueForKey("_shadowView") as? UIView {
                shadowView.alpha = alpha
                shadowView.isHidden = alpha == 0
            }

            if navigationBar.isTranslucent {
                if #available(iOS 10.0, *) {
                    if let backgroundEffectView = valueForKey("_backgroundEffectView") as? UIView, navigationBar.backgroundImage(for: .default) == nil {
                        backgroundEffectView.alpha = alpha
                        return
                    }

                } else {
                    if let adaptiveBackdrop = valueForKey("_adaptiveBackdrop") as? UIView , let backdropEffectView = adaptiveBackdrop.value(forKey: "_backdropEffectView") as? UIView {
                        backdropEffectView.alpha = alpha
                        return
                    }
                }
            }

            barBackgroundView.alpha = alpha
        }

    }
}



extension UINavigationController: UINavigationBarDelegate {

    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        print(#function)
        if let topVC = topViewController, let coor = topVC.transitionCoordinator, coor.initiallyInteractive {
            if #available(iOS 10.0, *) {
                coor.notifyWhenInteractionChanges({ (context) in
                    self.dealInteractionChanges(context)
                })
            } else {
                coor.notifyWhenInteractionEnds({ (context) in
                    self.dealInteractionChanges(context)
                })
            }
            return true
        }

        let itemCount = navigationBar.items?.count ?? 0
        let n = viewControllers.count >= itemCount ? 2 : 1
        let popToVC = viewControllers[viewControllers.count - n]
        if #available(iOS 13.0, *) {
            setNeedsNavigationBackground(alpha: popToVC.scnav.bgAlpha)
            navigationBar.tintColor = popToVC.scnav.tintColor
            navigationBar.titleTextAttributes = popToVC.scnav.titleTextAttributes
        } else {
            popToViewController(popToVC, animated: true)
        }
        return true
    }

    public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        print(#function)
        setNeedsNavigationBackground(alpha: topViewController?.scnav.bgAlpha ?? 0)
        navigationBar.tintColor = topViewController?.scnav.tintColor
        navigationBar.titleTextAttributes = topViewController?.scnav.titleTextAttributes
        return true
    }

    private func dealInteractionChanges(_ context: UIViewControllerTransitionCoordinatorContext) {
        let animations: (UITransitionContextViewControllerKey) -> () = {
            let nowAlpha = context.viewController(forKey: $0)?.scnav.bgAlpha ?? 0
            self.setNeedsNavigationBackground(alpha: nowAlpha)
            self.navigationBar.tintColor = context.viewController(forKey: $0)?.scnav.tintColor
            self.navigationBar.titleTextAttributes = context.viewController(forKey: $0)?.scnav.titleTextAttributes
        }

        if context.isCancelled {
            let cancelDuration: TimeInterval = context.transitionDuration * Double(context.percentComplete)
            UIView.animate(withDuration: cancelDuration) {
                animations(.from)
            }
        } else {
            let finishDuration: TimeInterval = context.transitionDuration * Double(1 - context.percentComplete)
            UIView.animate(withDuration: finishDuration) {
                animations(.to)
            }
        }
    }
}

fileprivate struct AssociatedKeys {
    static var bgAlpha = "bgAlpha"
    static var tintColor = "tintColor"
    static var hidden = "hidden"
    static var statusBarStyle = "statusBarStyle"
    static var titleTextAttributes = "titleTextAttributes"
}

extension DispatchQueue {

    private static var onceTracker = [String]()

    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

        if onceTracker.contains(token) {
            return
        }

        onceTracker.append(token)
        block()
    }
}


extension NSObject {
    func getIvar(forKey key: String) -> Any? {
        guard let _var = class_getInstanceVariable(type(of: self), key) else {
            return nil
        }

        return object_getIvar(self, _var)
    }
}
