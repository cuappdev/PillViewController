//
//  PillView.swift
//  Eatery
//
//  Created by William Ma on 4/10/19.
//  Copyright © 2019 CUAppDev. All rights reserved.
//

import UIKit

open class PillView: UIControl {

    public let inactiveColor: UIColor

    private let leftStackView: UIStackView
    public let leftImageView = UIImageView()
    public let leftLabel = UILabel()
    public private(set) var leftSegmentSelected: Bool = true

    private let separatorView = UIView()

    private let rightStackView: UIStackView
    public let rightImageView = UIImageView()
    public let rightLabel = UILabel()

    init(inactiveColor: UIColor = UIColor(red: 125/255, green: 130/255, blue: 136/255, alpha: 1)) {
        self.inactiveColor = inactiveColor

        leftStackView = UIStackView(arrangedSubviews: [leftImageView, leftLabel])
        rightStackView = UIStackView(arrangedSubviews: [rightImageView, rightLabel])

        super.init(frame: .zero)

        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 1

        snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(264)
        }

        let attributeSizes = getAttributeSizes()
        leftImageView.snp.makeConstraints { make in
            make.width.height.equalTo(attributeSizes.iconSideLength)
        }

        leftLabel.font = .systemFont(ofSize: attributeSizes.fontSize, weight: .medium)

        leftStackView.isUserInteractionEnabled = false
        leftStackView.axis = .horizontal
        leftStackView.spacing = 6
        addSubview(leftStackView)
        leftStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().dividedBy(2)
        }

        separatorView.backgroundColor = inactiveColor
        addSubview(separatorView)
        separatorView.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.height.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }

        rightImageView.snp.makeConstraints { make in
            make.width.height.equalTo(attributeSizes.iconSideLength)
        }

        rightLabel.font = .systemFont(ofSize: attributeSizes.fontSize, weight: .medium)

        rightStackView.isUserInteractionEnabled = false
        rightStackView.axis = .horizontal
        rightStackView.spacing = 6
        addSubview(rightStackView)
        rightStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(1.5)
        }

        selectLeftSegment()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) will not be implemented")
    }

    open func selectLeftSegment() {
        leftSegmentSelected = true

        leftImageView.tintColor = tintColor
        leftLabel.textColor = tintColor

        rightImageView.tintColor = inactiveColor
        rightLabel.textColor = inactiveColor

        sendActions(for: .valueChanged)
    }

    open func selectRightSegment() {
        leftSegmentSelected = false

        leftImageView.tintColor = inactiveColor
        leftLabel.textColor = inactiveColor

        rightImageView.tintColor = tintColor
        rightLabel.textColor = tintColor

        sendActions(for: .valueChanged)
    }
    
    private func getAttributeSizes() -> (iconSideLength: Int, fontSize: CGFloat) {
        return UIScreen.main.nativeBounds.height <= 1136 ? (14, 12) : (16, 14)
    }

    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        if location.x > frame.width / 2, leftSegmentSelected {
            selectRightSegment()
        } else if location.x < frame.width / 2, !leftSegmentSelected {
            selectLeftSegment()
        }

        return false
    }

}
