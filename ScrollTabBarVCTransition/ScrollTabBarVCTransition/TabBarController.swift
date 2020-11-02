//
//  TabBarController.swift
//  ScrollTabBarVCTransition
//
//  Created by 钟奇龙 on 2020/11/1.
//  Copyright © 2020 钟奇龙. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    private var panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    
    private let tabBarDelegate = TabBarDelegate()
    
    private var subVCCount: Int {
        guard let count = viewControllers?.count else {
            return 0
        }
        return count
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = tabBarDelegate
        
        panGesture.addTarget(self, action: #selector(TabBarController.handlePan(panGesture:)))
        view.addGestureRecognizer(panGesture)
        // Do any additional setup after loading the view.
    }
    
    @objc func handlePan(panGesture: UIPanGestureRecognizer){
        let translationX =  panGesture.translation(in: view).x
        let translationAbs = translationX > 0 ? translationX : -translationX
        let progress = translationAbs / view.frame.width
        switch panGesture.state{
        case .began:
            tabBarDelegate.interactive = true
            let velocityX = panGesture.velocity(in: view).x
            NSLog("\(velocityX)")
            // 向左滑小于 0，向右滑大于 0
            if velocityX < 0{
                if selectedIndex < subVCCount - 1{
                    selectedIndex += 1
                }
            } else {
                if selectedIndex > 0{
                    selectedIndex -= 1
                }
            }
        case .changed:
            tabBarDelegate.interactionController.update(progress)
        case .cancelled, .ended:
            if progress > 0.3{
                tabBarDelegate.interactionController.completionSpeed = 0.99
                tabBarDelegate.interactionController.finish()
            }else{
                tabBarDelegate.interactionController.completionSpeed = 0.99
                tabBarDelegate.interactionController.cancel()
            }
            tabBarDelegate.interactive = false
        default: break
        }
    }
}
