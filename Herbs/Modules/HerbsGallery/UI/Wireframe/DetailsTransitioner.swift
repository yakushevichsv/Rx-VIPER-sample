//
//  DetailsTransitioner.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/15/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import UIKit

//MARK: - DetailsTransitioner
final class DetailsTransitioner: NSObject {
    fileprivate let transitioning = AnimatedTransitioning()
    
    var originFrame: CGRect {
        get {
            return transitioning.originFrame
        }
        set(newValue) {
            transitioning.originFrame = newValue
        }
    }
    
    var initialBlock: (()->Void)? {
        get {
            return transitioning.initialBlock
        }
        set(newValue) {
            transitioning.initialBlock = newValue
        }
    }
    
    var completionBlock: (()->Void)? {
        get {
            return transitioning.completionBlock
        }
        set(newValue) {
            transitioning.completionBlock = newValue
        }
    }
    
    override init() {
        super.init()
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension DetailsTransitioner: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitioning
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitioning
    }
}

//MARK: - AnimatedTransitioning
final class AnimatedTransitioning: NSObject {
    let presentDuration: TimeInterval = 1.0
    var originFrame = CGRect.zero
    var completionBlock: (()->Void)? = nil
    var initialBlock: (()->Void)? = nil
}

//MARK: - UIViewControllerAnimatedTransitioning
extension AnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        debugPrint(#function)
        let toView = transitionContext.view(forKey: .to)
        /*container.addSubview(toView)
        toView?.alpha = 0.0*/
        
        initialBlock?()
        
        let presenting = toView != nil
        
        let detailsView: UIView = (presenting ? toView : transitionContext.view(forKey: .from))!
        
        let detailsVC = presenting == true ? transitionContext.viewController(forKey: .to) : transitionContext.viewController(forKey: .from)
        
        transitionContext.viewController(forKey: .to)
        
        let iFrame = presenting ? originFrame : detailsView.frame
        let fFrame = presenting ? detailsView.frame : originFrame
        
        let xScale = presenting ? iFrame.width/fFrame.width : fFrame.width/iFrame.width
        let yScale = presenting ? iFrame.height/fFrame.height : fFrame.height/iFrame.height
        
        let sTransform = CGAffineTransform(scaleX: xScale, y: yScale)
        
        if presenting {
            detailsView.transform = sTransform
            detailsView.center = CGPoint(x: iFrame.midX, y: iFrame.midY)
            detailsView.clipsToBounds = true
            detailsView.setNeedsLayout()
        }
        
        
        container.addSubview(detailsView)
        container.bringSubview(toFront: detailsView)
        
        let totalDuration = transitionDuration(using: transitionContext)
        
        
        UIView.animate(withDuration: 0.3 * totalDuration, animations: {
            if (presenting) {
                detailsVC?.view.alpha = presenting ? 1.0 : 0.0
            }
        }) { (finished) in
            
            UIView.animate(withDuration: (finished ? 0.7 : 0.0)  * totalDuration, animations: {
                detailsView.transform = presenting ? CGAffineTransform.identity : sTransform
                detailsView.center = CGPoint(x: fFrame.midX, y: fFrame.midY)
            }) { _ in
                transitionContext.completeTransition(true)
            }
        }
        
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        completionBlock?()
    }
}
