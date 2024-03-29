//
//  PillViewController.swift
//  Eatery
//
//  Created by William Ma on 4/10/19.
//  Copyright © 2019 CUAppDev. All rights reserved.
//

import SnapKit
import UIKit

open class PillViewController: UIViewController {

    public let pillView = PillView()
    private var showPillConstraints: [Constraint] = []
    private var hidePillConstraints: [Constraint] = []
    public private(set) var isShowingPill: Bool {
        didSet {
            if isShowingPill {
                for constraint in self.hidePillConstraints {
                    constraint.deactivate()
                }

                for constraint in self.showPillConstraints {
                    constraint.activate()
                }
            } else {
                for constraint in self.showPillConstraints {
                    constraint.deactivate()
                }
                for constraint in self.hidePillConstraints {
                    constraint.activate()
                }
            }
        }
    }

    private let containerView = UIView()
    public let leftViewController: UIViewController
    public let rightViewController: UIViewController

    private let bottomMargin: CGFloat

    public init(left: UIViewController, right: UIViewController, bottomMargin: CGFloat = 16) {
        self.leftViewController = left
        self.rightViewController = right
        self.isShowingPill = false

        self.bottomMargin = bottomMargin
        
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) will not be implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        containerView.backgroundColor = .clear
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        addChildViewController(leftViewController)
        containerView.addSubview(leftViewController.view)
        leftViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        leftViewController.didMove(toParentViewController: self)

        addChildViewController(rightViewController)
        containerView.addSubview(rightViewController.view)
        rightViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        rightViewController.didMove(toParentViewController: self)

        pillView.addTarget(self, action: #selector(pillSelectionDidChange), for: .valueChanged)
        view.addSubview(pillView)
        pillView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        showPillConstraints = pillView.snp.prepareConstraints { make in
            make.bottom.equalTo(view.snp.bottomMargin).inset(bottomMargin)
        }
        hidePillConstraints = pillView.snp.prepareConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(8)
        }

        leftViewController.view.preservesSuperviewLayoutMargins = true
        rightViewController.view.preservesSuperviewLayoutMargins = true
        containerView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 56, right: 0)

        setShowPill(true, animated: false)
        if pillView.leftSegmentSelected {
            showLeftViewController()
        } else {
            showRightViewController()
        }
    }

    open func setShowPill(_ showPill: Bool, animated: Bool) {
        view.layoutIfNeeded()
        let animation = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1) {
            self.isShowingPill = showPill
            self.view.layoutIfNeeded()
        }

        animation.startAnimation()
        if !animated {
            animation.stopAnimation(false)
            animation.finishAnimation(at: .end)
        }
    }

    @objc private func pillSelectionDidChange() {
        if pillView.leftSegmentSelected {
            showLeftViewController()
        } else {
            showRightViewController()
        }
    }

    private func showLeftViewController() {
        rightViewController.view.removeFromSuperview()
        
        containerView.addSubview(leftViewController.view)
        leftViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func showRightViewController() {
        leftViewController.view.removeFromSuperview()

        containerView.addSubview(rightViewController.view)
        rightViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
