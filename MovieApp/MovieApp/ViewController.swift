//
//  ViewController.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 20.01.2024.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

  private let apiKeyManager: ApiKeyManaging = ApiKeyManager()
  private lazy var apiService: APIServicing = APIService(apiKeyManager: apiKeyManager)
  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    apiService.getPopularTvShows(page: 1)
      .observe(on: MainScheduler.asyncInstance)
      .flatMap { responseModel -> Single<[TvShowDomainModel]> in
          .just(responseModel.results)
      }
      .subscribe(
        onSuccess: { [weak self] models in
          guard let self = self else { return }
          for tvShow in models {
            print(tvShow.name)
          }
        },
        onFailure: { _ in
        }
      )
      .disposed(by: disposeBag)
  }
}

