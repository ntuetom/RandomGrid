//
//  GridCollectionViewCell.swift
//  RandomGrid
//
//  Created by Wu hung-yi on 2024/4/9.
//  Copyright © 2024 Wu. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class GridCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemPink.withAlphaComponent(0.5)
        return v
    }()
    
    lazy var seperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    lazy var randomLabel: UILabel = {
        let lb = UILabel()
        lb.text = "random"
        lb.textColor = .black
        lb.isHidden = true
        lb.textAlignment = .center
        lb.lineBreakMode = .byTruncatingTail
        lb.font = UIFont.systemFont(ofSize: 40)
        lb.minimumScaleFactor = 0.2
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    
    lazy var bottomLineView: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        return v
    }()
    
    func setupSubView() {
        contentView.addSubview(bgView)
        bgView.addSubview(seperatorView)
        bgView.addSubview(randomLabel)
        bgView.addSubview(bottomLineView)
    }
    
    func setupConstraint() {
        bgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(kminOffset)
            make.trailing.equalToSuperview().offset(-kminOffset)
        }
        seperatorView.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.top.leading.trailing.equalToSuperview()
        }
        randomLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(kminOffset)
            make.trailing.equalToSuperview().offset(-kminOffset)
        }
        bottomLineView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(8)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }

    func toggleText(isToggle: Bool, isColumnSelected: Bool) {
        randomLabel.isHidden = !isToggle
        backgroundColor = isColumnSelected ? .cyan : .white
    }
}
