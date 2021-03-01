//
//  FoodListViewController.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/16/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import UIKit
import Combine
import SDWebImage

final class FoodListViewController: UICollectionViewController {

    private var foodList: [FoodListItem] = [] {
        didSet {
            applySnapshot()
        }
    }

    var didSelectFoodItem: ((FoodListItem) -> Void)?

    private let viewModel: FoodListViewModel
    private var searchController = UISearchController(searchResultsController: nil)

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, FoodListItem>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, FoodListItem>

    private enum Section: CaseIterable {
        case main
    }

    init(viewModel: FoodListViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.viewModel.foodEntitySubject.subscribe(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, foodListItem) -> UICollectionViewCell in
            let cell: FoodListCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.title.text = foodListItem.title

            cell.imageView.contentMode = .scaleAspectFill
            cell.imageView.sd_setImage(with: Endpoint.image(foodListItem.image).url,
                                       placeholderImage: #imageLiteral(resourceName: "Placeholder-image"),
                                       options: .retryFailed,
                                       context: nil)

            cell.imageTapped = { [weak self] in
//                print(foodListItem.title)

//                self?.didSelectFoodItem?(foodListItem)
//                let infoAlert = UIAlertController(title: "Tapped:", message: "\(foodList.title)", preferredStyle: .alert)
//                infoAlert.popoverPresentationController?.sourceView = cell
//                infoAlert.addAction(.init(title: "OK", style: .default, handler: nil))
//                self?.present(infoAlert, animated: true, completion: nil)
            }

            return cell
        }

        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private func setUI() {
        collectionView.register(FoodListCollectionViewCell.self)
        collectionView.collectionViewLayout = generateLayout()
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = .white
        viewModel.loadData()
        configureSearchController()
    }

    private func configureSearchController() {
      searchController.searchResultsUpdater = self
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.searchBar.placeholder = "Search Food"
      navigationItem.searchController = searchController
      definesPresentationContext = true
    }

    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        Section.allCases.forEach { snapshot.appendItems(foodList, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func generateLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))

        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)

        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 4,
                                                              leading: 4,
                                                              bottom: 4,
                                                              trailing: 4)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: fullPhotoItem, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension FoodListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchFoodList(for: searchController.searchBar.text)
    }
}

extension FoodListViewController: Subscriber {

    typealias Input = [FoodListItem]
    typealias Failure = Error

    /// Subscriber is willing recieve unlimited values upon subscription
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    /// .none, indicating that the subscriber will not adjust its demand
    func receive(_ input: [FoodListItem]) -> Subscribers.Demand {
        foodList = input
        return .none
    }

    /// Print the completion event
    func receive(completion: Subscribers.Completion<Error>) {
        print("Received completion", completion)
    }
}
