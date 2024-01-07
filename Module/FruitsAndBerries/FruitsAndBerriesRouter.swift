//
//  FruitsAndBerriesRouter.swift
//  iOS-Test
//

import UIKit
import Swinject

protocol FruitsAndBerriesRoutingLogic {
  
}

class FruitsAndBerriesRouter {
  
  weak var controller: FruitsAndBerriesViewController?
  
}

extension FruitsAndBerriesRouter: FruitsAndBerriesRoutingLogic {
  
}

extension FruitsAndBerriesRouter {
  
  static func createModule() -> FruitsAndBerriesViewController {
    guard let api = Assembler.shared.resolver.resolve(API.self) else {
      fatalError("assembler hasn't found appropriate instance with API argument")
    }
    let controller = FruitsAndBerriesViewController()

    let interactor = FruitsAndBerriesInteractor(api: api)
    let presenter = FruitsAndBerriesPresenter(api: api)
    let router = FruitsAndBerriesRouter()
    
    controller.interactor = interactor
    controller.router = router
    interactor.presenter = presenter
    presenter.view = controller
    return controller
  }
  
}
