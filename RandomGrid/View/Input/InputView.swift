//
//  InputView.swift
//  RandomGrid
//
//  Created by Wu hung-yi on 2024/4/9.
//  Copyright © 2024 Wu. All rights reserved.
//

import UIKit

class InputView: InputContentView {
    
    let viewModel = InputViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        setupSubView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var rowLabel: UILabel = {
        let lb = UILabel()
        lb.text = "列數:"
        return lb
    }()
    
    lazy var columnLabel: UILabel = {
        let lb = UILabel()
        lb.text = "欄數:"
        return lb
    }()
    
    lazy var rowTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "請輸入大於0的整數"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    lazy var columnTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "請輸入大於0的整數"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    lazy var hintLabel: UILabel = {
        let lb = UILabel()
        lb.isHidden = true
        lb.textColor = .red
        return lb
    }()
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("確定", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onClick), for: .touchDown)
        return btn
    }()
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
    }
    
    func setupSubView() {
        addSubview(rowLabel)
        addSubview(columnLabel)
        addSubview(rowTextField)
        addSubview(columnTextField)
        addSubview(hintLabel)
        addSubview(button)
    }

    func setupConstraint() {
        rowLabel.snp.makeConstraints { make in
            make.height.equalTo(kScreenH/10)
            make.leading.equalToSuperview().offset(kOffset)
            make.top.equalToSuperview().offset(kOffset)
        }
        columnLabel.snp.makeConstraints { make in
            make.height.equalTo(kScreenH/10)
            make.leading.equalToSuperview().offset(kOffset)
            make.top.equalTo(rowLabel.snp.bottom).offset(kOffset)
        }
        rowTextField.snp.makeConstraints { make in
            make.width.equalTo(kScreenW*2/3)
            make.height.equalTo(rowLabel)
            make.centerY.equalTo(rowLabel)
            make.leading.equalTo(rowLabel.snp.trailing).offset(kOffset)
            make.trailing.equalToSuperview().offset(-kOffset)
        }
        columnTextField.snp.makeConstraints { make in
            make.width.equalTo(kScreenW*2/3)
            make.height.equalTo(columnLabel)
            make.centerY.equalTo(columnLabel)
            make.leading.equalTo(rowTextField)
            make.trailing.equalToSuperview().offset(-kOffset)
        }
        hintLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(columnTextField.snp.bottom).offset(kOffset)
        }
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(hintLabel.snp.bottom).offset(kOffset)
            make.bottom.equalToSuperview().offset(-kOffset)
        }
    }
    
    @objc func onClick() {
        guard let row = rowTextField.text, let column = columnTextField.text else {
            return
        }
        viewModel.setData(row: row, column: column)
        let checkData = viewModel.checkValue()
        if checkData.isValid {
            deleage.onClose(data: (row: viewModel.row, column: viewModel.column))
            endEditing(true)
        } else {
            hintLabel.isHidden = false
            hintLabel.text = checkData.err
        }
    }
}
