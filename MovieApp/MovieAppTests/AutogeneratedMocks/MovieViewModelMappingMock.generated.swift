// Generated using Sourcery 2.1.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// For more details check wiki:
// https://github.com/deliveryhero/dh-verticals-ios/wiki/Automatic-mock-generation-using-Sourcery
// swiftlint:disable all

import Foundation
import UIKit
import RxSwift
@testable import MovieApp

class MovieViewModelMappingMock: MovieViewModelMapping {

  enum Invocations: Equatable {
    case movieViewModel
  }

  var invocations: [Invocations] = []

    //MARK: - movieViewModel

    var movieViewModelDomainModelCallsCount = 0
    var movieViewModelDomainModelCalled: Bool {
        return movieViewModelDomainModelCallsCount > 0
    }
    var movieViewModelDomainModelReceivedDomainModel: (MovieDomainModel)?
    var movieViewModelDomainModelReceivedInvocations: [(MovieDomainModel)] = []
    var movieViewModelDomainModelReturnValue: MovieViewModel!
    var movieViewModelDomainModelClosure: ((MovieDomainModel) -> MovieViewModel)?

    func movieViewModel(domainModel: MovieDomainModel) -> MovieViewModel {
      invocations.append(.movieViewModel)
      movieViewModelDomainModelCallsCount += 1
        movieViewModelDomainModelReceivedDomainModel = domainModel
        movieViewModelDomainModelReceivedInvocations.append(domainModel)
        if let movieViewModelDomainModelClosure = movieViewModelDomainModelClosure {
            return movieViewModelDomainModelClosure(domainModel)
        } else {
            return movieViewModelDomainModelReturnValue
        }
    }

}
