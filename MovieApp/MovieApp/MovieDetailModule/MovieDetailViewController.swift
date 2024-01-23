//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
import Kingfisher
import RxSwift
import UIKit

enum DetailsSectionType: Int, CaseIterable {
  case poster
  case overview
  case title
  case genre
}

final class MovieDetailViewController: UIViewController {
  var apiService: APIServicing?
  var mapper: MovieDetailsMapping?
  private var viewModel: MovieDetailViewModelling!
  
  var movieDomainModel: MovieDomainModel?
  private var dataSource: UICollectionViewDiffableDataSource<DetailsSectionType, MovieDetails>!
  private let disposeBag = DisposeBag()

  private var movieDetailsCollectionView: UICollectionView = {
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

    if let movieDomainModel = movieDomainModel {
      self.navigationItem.title = movieDomainModel.title
    }
    setUp()
    setUpCollectionViewDataSource()
    
    guard let apiService = apiService,
          let mapper = mapper,
          let movieDomainModel = movieDomainModel else {
      return
    }

    viewModel = MovieDetailViewModel(
      apiService: apiService,
      mapper: mapper,
      domainModel: movieDomainModel
    )
    setUpObservers()
    viewModel.loadDetails()
  }
}

private extension MovieDetailViewController {
  func setUp() {
    view.backgroundColor = UIColor.white
    view.addSubview(movieDetailsCollectionView)

    NSLayoutConstraint.activate([
      movieDetailsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      movieDetailsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      movieDetailsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      movieDetailsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    movieDetailsCollectionView.delegate = self
  }

  func setUpCollectionViewDataSource() {
    // Register cells
    movieDetailsCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: "PosterCollectionViewCell")
    movieDetailsCollectionView.register(TitleDetailCollectionViewCell.self, forCellWithReuseIdentifier: "TitleDetailCollectionViewCell")
    movieDetailsCollectionView.register(GenreDetailCollectionViewCell.self, forCellWithReuseIdentifier: "GenreDetailCollectionViewCell")
    movieDetailsCollectionView.register(OverviewCollectionViewCell.self, forCellWithReuseIdentifier: "OverviewCollectionViewCell")

    // Create data source for collection view
    dataSource = UICollectionViewDiffableDataSource<DetailsSectionType, MovieDetails>(
      collectionView: movieDetailsCollectionView
    ) { collectionView, indexPath, item in
      if let posterModel = item as? PosterDetail {
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: "PosterCollectionViewCell", for: indexPath
        ) as! PosterCollectionViewCell

        // Configure cell ui elements with view model data
        cell.configure(with: posterModel)

        return cell
      } else if let overviewModel = item as? OverviewDetail {
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: "OverviewCollectionViewCell", for: indexPath
        ) as! OverviewCollectionViewCell

        // Configure cell ui elements with view model data
        cell.configure(with: overviewModel)

        return cell
      } else if let titleModel = item as? TitleDetail {
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: "TitleDetailCollectionViewCell", for: indexPath
        ) as! TitleDetailCollectionViewCell

        // Configure cell ui elements with view model data
        cell.configure(with: titleModel)

        return cell
      } else if let genreModel = item as? GenreDetail {
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: "GenreDetailCollectionViewCell", for: indexPath
        ) as! GenreDetailCollectionViewCell

        // Configure cell ui elements with view model data
        cell.configure(with: genreModel)

        return cell
      }
      return UICollectionViewCell()
    }
  }
  func setUpObservers() {
    // Bind viewModel and view
    viewModel.movieDetails
      .observe(on: MainScheduler.asyncInstance)
      .subscribe { [weak self] (movieDetails: [DataSourceSection<DetailsSectionType>]) in
        guard let self = self else { return }
        applySnapshot(movieDetails: movieDetails)
      }
      .disposed(by: disposeBag)
  }
  
  func applySnapshot(movieDetails: [DataSourceSection<DetailsSectionType>]) {
    var snapshot = NSDiffableDataSourceSnapshot<DetailsSectionType, MovieDetails>()
    for dataSource in movieDetails {
      let sectionType: DetailsSectionType = dataSource.sectionType
      if snapshot.indexOfSection(sectionType) == nil {
        snapshot.appendSections([sectionType])
      }
      snapshot.appendItems(dataSource.rows, toSection: sectionType)
    }

    dataSource.apply(snapshot, animatingDifferences: true)
    movieDetailsCollectionView.collectionViewLayout.invalidateLayout()
  }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = collectionView.frame.width
    guard let cell = collectionView.cellForItem(at: indexPath) as? MovieDetailCell,
          let model = viewModel.movieDetails(for: indexPath.row, cell: cell) as? any DiffableModel
    else {
      return CGSize(width: width, height: 50.0)
    }
    cell.configure(with: model)
    let cellSize = cell.systemLayoutSizeFitting(
      CGSize(width: width, height: 0),
      withHorizontalFittingPriority: .required,
      verticalFittingPriority: .fittingSizeLevel
    )
    return cellSize
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
