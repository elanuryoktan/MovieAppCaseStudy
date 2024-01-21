//
//  ViewController.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 20.01.2024.
//

import UIKit

class ViewController: UIViewController {

  private let apiKeyManager: ApiKeyManaging = ApiKeyManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    apiKeyManager.tmdbApiKey { apiKey in
      print(apiKey)
    }
  }
}

