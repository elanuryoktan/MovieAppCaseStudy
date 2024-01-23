//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 22.01.2024.
//

import Foundation
import RxSwift
import UIKit

protocol MovieListViewing: AnyObject {
  
}

enum SectionType: Int, CaseIterable {
  case movie
}

final class MovieListViewController: UIViewController {
  var apiService: APIServicing?
  var mapper: MovieViewModelMapping?

  private var viewModel: MovieListViewModel!
  private var dataSource: UICollectionViewDiffableDataSource<SectionType, MovieViewModel>!
  private var snapshot = NSDiffableDataSourceSnapshot<SectionType, MovieViewModel>()
  private let disposeBag = DisposeBag()

  private var moviesCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.backgroundColor = UIColor.clear
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
    setUpCollectionViewDataSource()

    guard let apiService = apiService,
          let mapper = mapper else {
      return
    }

    viewModel = MovieListViewModel(
      apiService: apiService,
      mapper: mapper
    )
    setUpObservers()
    viewModel.onViewSetUp()
  }
}

extension MovieListViewController: MovieListViewing {
  
}

private extension MovieListViewController {
  func setUp() {
    view.backgroundColor = UIColor.white
    view.addSubview(moviesCollectionView)

    NSLayoutConstraint.activate([
      moviesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      moviesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    moviesCollectionView.delegate = self
    
    self.navigationItem.title = "Popular Movies"
  }

  func setUpCollectionViewDataSource() {
    // Create data source for collection view
    moviesCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")

    dataSource = UICollectionViewDiffableDataSource<SectionType, MovieViewModel>(
      collectionView: moviesCollectionView
    ) { collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "MovieCollectionViewCell", for: indexPath
      ) as! MovieCollectionViewCell

      // Configure cell ui elements with view model data
      cell.configure(with: item)

      return cell
    }
  }

  func setUpObservers() {
    // Bind viewModel and view
    viewModel.movies
      .observe(on: MainScheduler.asyncInstance)
      .subscribe { [weak self] movieList in
        guard let self = self else { return }
        applySnapshot(movies: movieList)
      }
      .disposed(by: disposeBag)
    
    viewModel.errorMessage
      .observe(on: MainScheduler.asyncInstance)
      .subscribe { [weak self] (message: (String, String)) in
        guard let self = self else { return }
        self.presentAlert(title: message.0, message: message.1, actionText: "OK")
      }
      .disposed(by: disposeBag)
  }
  
  func presentAlert(
    title: String,
    message: String,
    actionText: String,
    handler: ((UIAlertAction) -> Void)? = nil
  ) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: actionText, style: UIAlertAction.Style.default, handler: handler))
    present(alert, animated: true, completion: nil)
  }

  func applySnapshot(movies: [MovieViewModel]) {
    if snapshot.indexOfSection(.movie) == nil {
      snapshot.appendSections([.movie])
    }
    snapshot.appendItems(movies, toSection: .movie)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = collectionView.frame.width
    guard let movieViewModel = viewModel.movieViewModel(for: indexPath.row) else {
      return CGSize(width: width, height: 50.0)
    }
    let cell = MovieCollectionViewCell()
    cell.configure(with: movieViewModel)
    let cellSize = cell.systemLayoutSizeFitting(
      CGSize(width: width, height: 0),
      withHorizontalFittingPriority: .required,
      verticalFittingPriority: .fittingSizeLevel
    )
    return cellSize
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height {
      viewModel.onLoadNextPage()
    }
  }
}
