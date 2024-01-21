//
//  UserDefaultsManager.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 21.01.2024.
//

import Foundation

protocol UserDefaultsManaging {
  func getApiKey() -> String?
  func setApiKey(apiKey: String)
}

final class UserDefaultsManager: UserDefaultsManaging {
  enum UserDefaultsKeys: String {
    case apiKey = "apiKey"
  }

  func getApiKey() -> String? {
    return UserDefaults.standard.string(forKey: UserDefaultsKeys.apiKey.rawValue)
  }
  
  func setApiKey(apiKey: String) {
    UserDefaults.standard.set(apiKey, forKey: UserDefaultsKeys.apiKey.rawValue)
  }
}
