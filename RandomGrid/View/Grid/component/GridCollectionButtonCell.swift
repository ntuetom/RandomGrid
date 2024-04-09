//
//  GridCollectionButtonCell.swift
//  RandomGrid
//
//  Created by Wu hung-yi on 2024/4/9.
//  Copyright © 2024 Wu. All rights reserved.
//

import UIKit
import RxSwift

class GridCollectionButtonCell: UICollectionViewCell {
    
    var disposeBag = DisposeBag(
    )
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        setupSubView()
        setupConstraint()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgView: UIView = {
        let v = UIView()
        v.backgroundColor = .darkGray
        return v
    }()
    
    lazy var seperatorBGView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    lazy var seperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.backgroundColor = .clear
        return btn
    }()
    
    lazy var label: UILabel = {
        let lb = UILabel()
        lb.textColor = .lightGray
        lb.highlightedTextColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.text = "確定"
        return lb
    }()
    
    func setupSubView() {
        contentView.addSubview(bgView)
        contentView.addSubview(seperatorBGView)
        seperatorBGView.addSubview(seperatorView)
        bgView.addSubview(button)
        bgView.addSubview(label)
    }
    
    func setupConstraint() {
        seperatorBGView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        seperatorView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(kminOffset)
            make.trailing.equalToSuperview().offset(-kminOffset)
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(seperatorBGView.snp.bottom)
            make.leading.equalToSuperview().offset(kminOffset)
            make.trailing.bottom.equalToSuperview().offset(-kminOffset)
        }
        button.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(kminOffset)
            make.trailing.bottom.equalToSuperview().offset(-kminOffset)
        }
        label.snp.makeConstraints { make in
            make.centerX.equalTo(button)
            make.bottom.equalTo(button).offset(-kOffset)
        }
    }
    
    func setup(toggle: Bool, tapEvent: PublishSubject<Void>) {
        toggleButton(toggel: toggle)
        if toggle {
            button.rx.tap.bind(to: tapEvent).disposed(by: disposeBag)
        }
    }
    
    func toggleButton(toggel: Bool) {
        if toggel {
            button.backgroundColor = .cyan
            backgroundColor = .cyan
            seperatorBGView.backgroundColor = .cyan
        } else {
            button.backgroundColor =  .clear
            backgroundColor = .darkGray
            seperatorBGView.backgroundColor = .white
        }
        label.isHighlighted = toggel
    }
}
