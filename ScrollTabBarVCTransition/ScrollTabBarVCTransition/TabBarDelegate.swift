//
//  TabBarDelegate.swift
//  ScrollTabBarVCTransition
//
//  Created by 钟奇龙 on 2020/11/1.
//  Copyright © 2020 钟奇龙. All rights reserved.
//

import UIKit

class TabBarDelegate: NSObject, UITabBarControllerDelegate {
    
    var interactive = false
    let interactionController = UIPercentDrivenInteractiveTransition()
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let fromIndex = tabBarController.viewControllers?.firstIndex(of: fromVC) else {
            return nil
        }
        
        guard let toIndex = tabBarController.viewControllers?.firstIndex(of: toVC) else {
            return nil
        }
        
        let tabChangeDirection: TabOperationDirection = toIndex < fromIndex ? TabOperationDirection.left: TabOperationDirection.right
        
        let transitionType = TransitionType.tabTransition(tabChangeDirection)
        
        let slideAnimationController = SlideAnimationController(type: transitionType)
        return slideAnimationController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? interactionController : nil
    }
}
