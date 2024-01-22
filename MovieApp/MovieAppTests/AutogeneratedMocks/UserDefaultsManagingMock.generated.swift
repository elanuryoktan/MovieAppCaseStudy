// Generated using Sourcery 2.1.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// For more details check wiki:
// https://github.com/deliveryhero/dh-verticals-ios/wiki/Automatic-mock-generation-using-Sourcery
// swiftlint:disable all

import Foundation
import UIKit
import RxSwift
@testable import MovieApp

class UserDefaultsManagingMock: UserDefaultsManaging {

  enum Invocations: Equatable {
    case getApiKey
    case setApiKey
  }

  var invocations: [Invocations] = []

    //MARK: - getApiKey

    var getApiKeyCallsCount = 0
    var getApiKeyCalled: Bool {
        return getApiKeyCallsCount > 0
    }
    var getApiKeyReturnValue: String?
    var getApiKeyClosure: (() -> String?)?

    func getApiKey() -> String? {
      invocations.append(.getApiKey)
      getApiKeyCallsCount += 1
        if let getApiKeyClosure = getApiKeyClosure {
            return getApiKeyClosure()
        } else {
            return getApiKeyReturnValue
        }
    }

    //MARK: - setApiKey

    var setApiKeyApiKeyCallsCount = 0
    var setApiKeyApiKeyCalled: Bool {
        return setApiKeyApiKeyCallsCount > 0
    }
    var setApiKeyApiKeyReceivedApiKey: (String)?
    var setApiKeyApiKeyReceivedInvocations: [(String)] = []
    var setApiKeyApiKeyClosure: ((String) -> Void)?

    func setApiKey(apiKey: String) {
      invocations.append(.setApiKey)
      setApiKeyApiKeyCallsCount += 1
        setApiKeyApiKeyReceivedApiKey = apiKey
        setApiKeyApiKeyReceivedInvocations.append(apiKey)
      setApiKeyApiKeyClosure?(apiKey)
    }

}
