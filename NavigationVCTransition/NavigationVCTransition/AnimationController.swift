//
//  AnimationController.swift
//  NavigationVCTransition
//
//  Created by 钟奇龙 on 2020/11/2.
//  Copyright © 2020 钟奇龙. All rights reserved.
//

import UIKit

enum TransitionType{
    case navigationTransition(UINavigationController.Operation)
    case tabTransition(TabOperationDirection)
    case modalTransition(ModalOperation)
}

enum TabOperationDirection{
    case left, right
}

enum ModalOperation{
    case presentation, dismissal
}

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    private var transitionType: TransitionType

    init(type: TransitionType) {
        transitionType = type
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else{
            return
        }
        
        let fromView = fromVC.view
        let toView = toVC.view
        
        var translation = containerView.frame.width
        var toViewTransform = CGAffineTransform.identity
        var fromViewTransform = CGAffineTransform.identity
        
        switch transitionType{
        case .navigationTransition(let operation):
            translation = operation == .push ? translation : -translation
            toViewTransform = CGAffineTransform(translationX: translation, y: 0)
            toViewTransform = toViewTransform.rotated(by: 0.3)
            fromViewTransform = CGAffineTransform(translationX: -translation, y: 0)
        case .tabTransition(let direction):
            translation = direction == .left ? translation : -translation
            fromViewTransform = CGAffineTransform(translationX: translation, y: 0)
            toViewTransform = CGAffineTransform(translationX: -translation, y: 0)
        case .modalTransition(let operation):
            translation =  containerView.frame.height
            toViewTransform = CGAffineTransform(translationX: 0, y: (operation == .presentation ? translation : 0))
            fromViewTransform = CGAffineTransform(translationX: 0, y: (operation == .presentation ? 0 : translation))
        }

        switch transitionType{
        case .modalTransition(let operation):
            switch operation{
            case .presentation: containerView.addSubview(toView!)
            case .dismissal: break
            }
        default: containerView.addSubview(toView!)
        }
        
        toView?.transform = toViewTransform
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView?.transform = fromViewTransform
            toView?.transform = CGAffineTransform.identity
            }, completion: { finished in
                fromView?.transform = CGAffineTransform.identity
                toView?.transform = CGAffineTransform.identity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
