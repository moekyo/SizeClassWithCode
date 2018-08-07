//
//  ViewController.swift
//  SizeClassDemo
//
//  Created by edaotech on 2018/8/7.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var blueView: UIView!
    var constraints: [NSLayoutConstraint]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        blueView = UIView()
        blueView.backgroundColor = .blue
        view.addSubview( blueView)
        blueView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = blueView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        blueView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        blueView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        let newConstraint = blueView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        topConstraint.identifier = "topConstraint"
        newConstraint.identifier = "newConstraint"
        constraints = [topConstraint, newConstraint]
        setupTopConstraint(traitCollection: traitCollection)
        
        
    }
    
    
    func setupTopConstraint(traitCollection: UITraitCollection) -> Void {
        //因为后面在旋转屏幕的瞬间会让 constraints 里面的约束同时生效(isActive 皆为 true)导致冲突,所以在旋转开始前将约束失效
        constraints.forEach { (constraint) in
            constraint.isActive = false
        }
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .compact {//横屏
            self.constraints.first?.isActive = false
            self.constraints.last?.isActive = true
        } else if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            self.constraints.first?.isActive = true
            self.constraints.last?.isActive = false
        }

    }
    

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super .willTransition(to: newCollection, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.setupTopConstraint(traitCollection: newCollection)

        }, completion: nil)

    }
    

}

