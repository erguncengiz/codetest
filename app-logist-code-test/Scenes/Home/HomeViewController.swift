//
//  HomeViewController.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func display(viewModel: Home.Grocery.ViewModel)
    func didReceiveData()
    func setSelectedGrocery(index: Int, count: Int?, grocery: Home.Product?)
    func removeSelectedGrocery(index: Int)
    func setCurrentBasketCount(count: Int)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    // MARK: Outlets
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var basketCountLabel: UILabel!
    
    // MARK: Variables
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic)?
    var cells: [Home.Cell]?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCountLabel()
        let request = Home.Grocery.Request()
        interactor?.handle(request: request)
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        GroceryCollectionViewCell.registerWithNib(to: collectionView)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView.reloadData()
        collectionView.collectionViewLayout = layout
        collectionView.isHidden = true
        
        let margin: CGFloat = 10
        guard let collectionView = collectionView,
              let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func configureCountLabel() {
        basketCountLabel.backgroundColor = .orange
        basketCountLabel.layer.cornerRadius = 8
        basketCountLabel.layer.masksToBounds = true
    }
    
    // MARK: Requests
    
    func display(viewModel: Home.Grocery.ViewModel) {
        cells = viewModel.result
    }
    
    func didReceiveData() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        }
    }
    
    func setSelectedGrocery(index: Int, count: Int?, grocery: Home.Product?) {
        interactor?.setSelectedGrocery(index: index, count: count, grocery: grocery)
    }
    
    func removeSelectedGrocery(index: Int) {
        interactor?.removeSelectedGrocery(index: index)
    }
    
    func setCurrentBasketCount(count: Int) {
        basketCountLabel.text = "\(count)"
    }
    
    @IBAction func didBasketClicked(_ sender: Any) {
        router?.routeToBasket(vc: self)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells?[indexPath.row].identifier() ?? "GroceryCollectionViewCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let item = cells?[indexPath.row]
        
        switch item {
        case .cell(let model):
            guard let cell = cell as? GroceryCollectionViewCell else { return }
            cell.willDisplay(model: model, index: indexPath.row, viewController: self)
        case .none:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = (collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow)
        return CGSize(width: size, height: size * 1.4)
    }
    
}
