//
//  GridViewController.swift
//  RandomGrid
//
//  Created by Wu hung-yi on 2024/4/9.
//  Copyright © 2024 Wu. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class GridViewController: UIViewController {

    let viewModel: GridViewModel
    var examView: GridView!
    var disposeBag = DisposeBag()
    weak var collectionView: UICollectionView!
    
    lazy var dataSource = {
        return RxCollectionViewSectionedAnimatedDataSource<CustomSectionDataType>(
            configureCell: { [weak self] (dataSource, cv, indexPath, item) in
            if let self = self {
                  let data = dataSource.sectionModels[indexPath.section].items[indexPath.row]
                  switch data.dataType {
                  case .randomCell:
                      if let cell = cv.dequeueReusableCell(withReuseIdentifier: "GridCollectionViewCell", for: indexPath) as? GridCollectionViewCell {
                          cell.toggleText(isToggle: data.isSelected, isColumnSelected: data.columnSelected)
                          return cell
                      }
                  case .buttnCell:
                      if let cell = cv.dequeueReusableCell(withReuseIdentifier: "GridCollectionButtonCell", for: indexPath) as? GridCollectionButtonCell {
                          cell.setup(toggle: data.columnSelected, tapEvent: self.viewModel.resetDidClick)
                          return cell
                      }
                  }
                  return UICollectionViewCell()
              }
              return UICollectionViewCell()
          })
    }()
    
    init(row: Int, column: Int) {
        viewModel = GridViewModel(row: row, column: column)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
    
    override func loadView() {
        examView = GridView(vm: viewModel, owner: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.rowSource.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        presentPopup()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            examView.didRoate()
       }

    func presentPopup() {
        let vc = InputViewController(contentView: InputView()) { [weak self] data in
            guard let `self` = self, let index = data as? (row: Int, column: Int) else {
                return
            }
            self.viewModel.setupInput(row: index.row, column: index.column)
            self.collectionView.reloadData()
        }
        vc.modalPresentationStyle = .overCurrentContext
        let rootVC = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController
        rootVC?.present(vc, animated: true)
    }

}

extension GridViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minSpace = viewModel.collectionCellMinimumLineSpacing
        
        return CGSize(
            width:   (collectionView.frame.size.width-CGFloat(viewModel.inputColumm-1)*minSpace) / CGFloat(viewModel.inputColumm),
            height: (collectionView.frame.size.height*(1)-CGFloat(viewModel.inputRow)*minSpace) / CGFloat(viewModel.inputRow+1)
        )
    }

}

