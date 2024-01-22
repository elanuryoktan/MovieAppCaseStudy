// Generated using Sourcery 2.1.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// For more details check wiki:
// https://github.com/deliveryhero/dh-verticals-ios/wiki/Automatic-mock-generation-using-Sourcery
// swiftlint:disable all

import Foundation
import UIKit
import RxSwift
@testable import MovieApp

class ApiKeyManagingMock: ApiKeyManaging {

  enum Invocations: Equatable {
    case tmdbApiKey
  }

  var invocations: [Invocations] = []

    //MARK: - tmdbApiKey

    var tmdbApiKeyCompletionCallsCount = 0
    var tmdbApiKeyCompletionCalled: Bool {
        return tmdbApiKeyCompletionCallsCount > 0
    }
    var tmdbApiKeyCompletionReceivedCompletion: (((String?) -> Void))?
    var tmdbApiKeyCompletionReceivedInvocations: [(((String?) -> Void))] = []
    var tmdbApiKeyCompletionClosure: ((@escaping (String?) -> Void) -> Void)?

    func tmdbApiKey(completion: @escaping (String?) -> Void) {
      invocations.append(.tmdbApiKey)
      tmdbApiKeyCompletionCallsCount += 1
        tmdbApiKeyCompletionReceivedCompletion = completion
        tmdbApiKeyCompletionReceivedInvocations.append(completion)
      tmdbApiKeyCompletionClosure?(completion)
    }

}
