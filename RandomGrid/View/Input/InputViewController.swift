//
//  InputViewController.swift
//  RandomGrid
//
//  Created by Wu hung-yi on 2024/4/9.
//  Copyright © 2024 Wu. All rights reserved.
//

import UIKit

protocol InputDelegate: NSObjectProtocol {
    func onClose(data: Any)
}

class InputContentView: UIView {
    weak var deleage: InputDelegate!
}

class InputViewController: UIViewController, InputDelegate {

    weak var contentView: UIView!
    var completion: ((Any) -> Void)?
    
    init(contentView: InputContentView, completion: ((Any) -> Void)?) {
        super.init(nibName: nil, bundle: nil)
        self.contentView = contentView
        self.completion = completion
        view.addSubview(contentView)
        setupConstraint()
        contentView.deleage = self
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onTap))
        view.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit PopupViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         super.viewWillTransition(to: size, with: coordinator)
         setupConstraint()
    }
    
    func setupConstraint() {
        contentView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func onClose(data passData: Any) {
        completion?(passData)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onTap() {
        view.endEditing(true)
    }

}
