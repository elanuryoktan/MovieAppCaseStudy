//
//  ApiKeyManagerTests.swift
//  MovieAppTests
//
//  Created by Elanur Yoktan on 21.01.2024.
//

import Foundation
import XCTest
import FirebaseFirestore
@testable import MovieApp

final class ApiKeyManagerTests: XCTestCase {
  func testGetTmdbApiKeyFromUserDefaults() {
    let dependencies = ApiKeyManagerDependencies()
    dependencies.userDefaultsManager.getApiKeyReturnValue = "apiKey"
    let apiKeyManager = apiKeyManager(dependencies: dependencies)
    
    let expectation = expectation(description: "Get api key from UserDefaults")
    apiKeyManager.tmdbApiKey { apiKey in
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(dependencies.userDefaultsManager.invocations, [.getApiKey])
  }
  
  func testGetTmdbApiKeyFromFireStore() {
    let dependencies = ApiKeyManagerDependencies()
    let apiKeyManager = apiKeyManager(dependencies: dependencies)
    
    let expectation = expectation(description: "Get api key from Firestore")
    apiKeyManager.tmdbApiKey { apiKey in
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(dependencies.userDefaultsManager.invocations, [.getApiKey, .setApiKey])
  }
}

private extension ApiKeyManagerTests {
  func apiKeyManager(dependencies: ApiKeyManagerDependencies) -> ApiKeyManager {
    return ApiKeyManager(userDefaultsManager: dependencies.userDefaultsManager)
  }
}

struct ApiKeyManagerDependencies {
  let userDefaultsManager = UserDefaultsManagingMock()
}
