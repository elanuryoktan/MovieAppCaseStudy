//
//  ApiKeyManager.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 20.01.2024.
//

import Foundation
import FirebaseFirestore

// The ApiKeyManager is designed to securely manage the retrieval of the TMDB API key used in the application.
// Instead of hardcoding the key in the source code, it dynamically fetches the key from Firestore.
// sourcery: AutoMockable
protocol ApiKeyManaging {
  func tmdbApiKey(completion: @escaping (String?) -> Void)
}

final class ApiKeyManager: ApiKeyManaging {
  private enum Constants {
    static let collectionName = "configurations"
    static let documentName = "api_key_config"
    static let keyName = "apiKey"
  }

  private let userDefaultsManager: UserDefaultsManaging

  init(userDefaultsManager: UserDefaultsManaging) {
    self.userDefaultsManager = userDefaultsManager
  }

  func tmdbApiKey(completion: @escaping (String?) -> Void) {
    guard let apiKey = getApiKeyFromUserDefaults() else {
      fetchApiKeyFromFirestore { apiKey in
        completion(apiKey)
      }
      return
    }
    completion(apiKey)
  }
}

private extension ApiKeyManager {
  // Helper function to get API key from user defaults
  func getApiKeyFromUserDefaults() -> String? {
    return userDefaultsManager.getApiKey()
  }

  // Helper function to fetch API key from Firestore
  func fetchApiKeyFromFirestore(completion: @escaping (String?) -> Void) {
    let db = Firestore.firestore()
    let configurationsRef = db.collection(Constants.collectionName).document(Constants.documentName)
    
    configurationsRef.getDocument { [weak self] document, error in
      guard let self = self else { return }
      if let document = document, document.exists, let apiKey = document.data()?[Constants.keyName] as? String {
        self.userDefaultsManager.setApiKey(apiKey: apiKey)
        completion(apiKey)
      } else {
        completion(nil)
      }
    }
  }
}
