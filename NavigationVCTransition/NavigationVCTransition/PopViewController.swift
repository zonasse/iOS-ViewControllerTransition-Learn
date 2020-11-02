//
//  PopViewController.swift
//  NavigationVCTransition
//
//  Created by 钟奇龙 on 2020/11/2.
//  Copyright © 2020 钟奇龙. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {
    
    let edgePanGesture = UIScreenEdgePanGestureRecognizer()
    var navigationDelegate: NavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgePanGesture.edges = .right
        edgePanGesture.addTarget(self, action: #selector(handleEdgePanGesture(gesture:)))
        view.addGestureRecognizer(edgePanGesture)
        // Do any additional setup after loading the view.
    }
    
    @objc func handleEdgePanGesture(gesture: UIScreenEdgePanGestureRecognizer){
        let translationX =  gesture.translation(in: view).x
        let translationBase: CGFloat = view.frame.width / 3
        let translationAbs = translationX > 0 ? translationX : -translationX
        let percent = translationAbs > translationBase ? 1.0 : translationAbs / translationBase
        switch gesture.state{
        case .began:
            navigationDelegate = self.navigationController?.delegate as? NavigationDelegate
            navigationDelegate?.interactive = true
            _ = self.navigationController?.popViewController(animated: true)
        case .changed:
            navigationDelegate?.interactionController.update(percent)
        case .cancelled, .ended:
            if percent > 0.5{
                navigationDelegate?.interactionController.finish()
            }else{
                navigationDelegate?.interactionController.cancel()
            }
            navigationDelegate?.interactive = false
        default: break
        }
    }


}
