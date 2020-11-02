//
//  NavigationDelegate.swift
//  NavigationVCTransition
//
//  Created by 钟奇龙 on 2020/11/2.
//  Copyright © 2020 钟奇龙. All rights reserved.
//

import UIKit

class NavigationDelegate: NSObject, UINavigationControllerDelegate {

    var interactive = false
    let interactionController = UIPercentDrivenInteractiveTransition()
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitionType = TransitionType.navigationTransition(operation)
        return AnimationController(type: transitionType)
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
        return interactive ? self.interactionController : nil
    }
}
