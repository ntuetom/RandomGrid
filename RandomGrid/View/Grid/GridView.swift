//
//  GridView.swift
//  RandomGrid
//
//  Created by Wu hung-yi on 2024/4/9.
//  Copyright © 2024 Wu. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    let viewModel: GridViewModel
    var owner: AnyObject?
    
    init(vm: GridViewModel, owner: AnyObject?, frame: CGRect? = nil) {
        viewModel = vm
        super.init(frame: frame ?? .zero)
        self.owner = owner
        setupSubView()
        setupConstraint()
        setupRefernce()
        setupRefernceOutlets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var collectionViewlayout: UICollectionViewFlowLayout {
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.scrollDirection = .horizontal
        cvLayout.minimumLineSpacing = viewModel.collectionCellMinimumLineSpacing
        cvLayout.minimumInteritemSpacing = viewModel.collectionCellMinimumLineSpacing
        return cvLayout
    }
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
        cv.backgroundColor = .clear
        cv.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "GridCollectionViewCell")
        cv.register(GridCollectionButtonCell.self, forCellWithReuseIdentifier: "GridCollectionButtonCell")
        cv.backgroundColor = .white
        return cv
    }()
    
    func didRoate() {
        collectionView.setNeedsUpdateConstraints()
        collectionView.layoutIfNeeded()
    }
    
    func setupSubView() {
        addSubview(collectionView)
    }
    
    func setupConstraint(){
        collectionView.snp.remakeConstraints { make in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(safeAreaLayoutGuide)
            } else {
                make.edges.top.equalTo(layoutMarginsGuide)
            }
        }
    }
    
    func setupRefernce() {
        if owner != nil && owner!.isKind(of: UIViewController.classForCoder()){
            (owner as! UIViewController).view = self
        }
        if let vc = owner as? GridViewController {
            vc.collectionView = collectionView
        }
    }
    
    func setupRefernceOutlets() {
        if let vc = owner as? GridViewController {
            collectionView.delegate = vc
        }
    }
}
