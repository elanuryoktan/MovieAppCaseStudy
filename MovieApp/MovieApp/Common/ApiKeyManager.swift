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
protocol ApiKeyManaging {
  func tmdbApiKey(completion: @escaping (String?) -> Void)
}

final class ApiKeyManager: ApiKeyManaging {
  private enum Constants {
    static let collectionName = "configurations"
    static let documentName = "api_key_config"
    static let keyName = "apiKey"
  }

  func tmdbApiKey(completion: @escaping (String?) -> Void) {
    fetchApiKeyFromFirestore { apiKey in
      completion(apiKey)
    }
  }
}

private extension ApiKeyManager {
  // Helper function to fetch API key from Firestore
  func fetchApiKeyFromFirestore(completion: @escaping (String?) -> Void) {
    let db = Firestore.firestore()
    let configurationsRef = db.collection(Constants.collectionName).document(Constants.documentName)
    
    configurationsRef.getDocument { document, error in
      if let document = document, document.exists {
        let apiKey = document.data()?[Constants.keyName] as? String
        completion(apiKey)
      } else {
        completion(nil)
      }
    }
  }
}
