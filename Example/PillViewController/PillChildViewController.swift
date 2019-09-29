//
//  PillChildViewController.swift
//  PillViewController_Example
//
//  Created by William Ma on 9/29/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

/**
 A view controller with a label and a button.

 `showHidePillButtonPressed` is called when the button is pressed.
 */
class PillChildViewController: UIViewController {

    lazy var titleLabel = UILabel(frame: .zero)

    lazy var showHidePillButton = UIButton(type: .system)

    var showHidePillButtonPressed: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        showHidePillButton.setTitle("Show/Hide Pill", for: .normal)
        showHidePillButton.addTarget(self, action: #selector(showHidePillButtonPressed(_:)), for: .touchUpInside)
        view.addSubview(showHidePillButton)
        showHidePillButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(showHidePillButton.snp.top).offset(-16)
        }
    }

    @objc private func showHidePillButtonPressed(_ sender: UIButton) {
        showHidePillButtonPressed?()
    }

}
