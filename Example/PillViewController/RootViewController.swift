//
//  RootViewController.swift
//  PillViewController_Example
//
//  Created by William Ma on 9/29/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import PillViewController
import UIKit

/**
 The RootViewController contains an instance of PillViewController.
 */
class RootViewController: UIViewController {

    private lazy var leftViewController = PillChildViewController()
    private lazy var rightViewController = PillChildViewController()

    private lazy var pillViewController = PillViewController(left: leftViewController,
                                                             right: rightViewController,
                                                             bottomMargin: 32)

    override func viewDidLoad() {
        super.viewDidLoad()

        // configure left and right view controllers

        leftViewController.titleLabel.text = "Left View Controller"
        leftViewController.showHidePillButtonPressed = showHidePill

        rightViewController.titleLabel.text = "Right View Controller"
        rightViewController.showHidePillButtonPressed = showHidePill

        // configure pill controller

        addChildViewController(pillViewController)
        view.addSubview(pillViewController.view)
        pillViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pillViewController.didMove(toParentViewController: self)

        // configure pill

        let pillView = pillViewController.pillView
        pillView.leftLabel.text = "Left"
        pillView.leftImageView.image = UIImage(named: "campusIcon")
        pillView.rightLabel.text = "Right"
        pillView.rightImageView.image = UIImage(named: "collegetownIcon")
    }
    
    private func showHidePill() {
        pillViewController.setShowPill(!pillViewController.isShowingPill, animated: true)
    }

}
