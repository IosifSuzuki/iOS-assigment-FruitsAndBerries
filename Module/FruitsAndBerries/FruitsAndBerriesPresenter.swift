//
//  FruitsAndBerriesPresenter.swift
//  iOS-Test
//

import Foundation
import UIKit.UIColor

// Implemented by View layer (ViewControllers)
protocol FruitsAndBerriesPresentationLogic {
  func present(response: FruitsAndBerriesModels.Load.Response)
  func present(response: FruitsAndBerriesModels.Loading.Response)
  func present(response: FruitsAndBerriesModels.Alert.Response)
  func present(response: FruitsAndBerriesModels.SelectItem.Response)
  func present(response: FruitsAndBerriesModels.LoadDetail.Response)
}

class FruitsAndBerriesPresenter {
  weak var view: FruitsAndBerriesDisplayLogic?
  
  let api: API
  
  init(api: API) {
    self.api = api
  }
  
}

extension FruitsAndBerriesPresenter: FruitsAndBerriesPresentationLogic {
  
  // Transforms Load.Response into ViewModel to be displayed by the ViewController
  func present(response: FruitsAndBerriesModels.Load.Response) {
    let title = response.title
    let dataSource = response.items.map { groceryProduct in
      GroceryProductViewModel(
        title: groceryProduct.name,
        iconPath: api.icon(path: groceryProduct.image), 
        mainColor: UIColor(hex: groceryProduct.color)
      )
    }
    
    let viewModel = FruitsAndBerriesModels.Load.ViewModel(title: title, dataSource: dataSource)
    DispatchQueue.main.async { [weak self] in
      self?.view?.display(model: viewModel)
    }
  }
  
  func present(response: FruitsAndBerriesModels.Loading.Response) {
    let viewModel = FruitsAndBerriesModels.Loading.ViewModel(isLoading: response.isLoading)
    
    DispatchQueue.main.async { [weak self] in
      self?.view?.display(model: viewModel)
    }
  }
  
  func present(response: FruitsAndBerriesModels.Alert.Response) {
    DispatchQueue.main.async {
      let viewModel = FruitsAndBerriesModels.Alert.ViewModel(title: response.title, message: response.message)
      self.view?.display(model: viewModel)
    }
  }
  
  func present(response: FruitsAndBerriesModels.SelectItem.Response) {
    DispatchQueue.main.async {
      let viewModel = FruitsAndBerriesModels.SelectItem.ViewModel()
      self.view?.display(model: viewModel)
    }
  }
  
  func present(response: FruitsAndBerriesModels.LoadDetail.Response) {
    DispatchQueue.main.async {
      let viewModel = FruitsAndBerriesModels.LoadDetail.ViewModel(
        title: response.groceryProduct.name.capitalized,
        color: UIColor(hex: response.groceryProduct.color),
        iconPath: self.api.icon(path: response.groceryProduct.image),
        text: response.groceryProductDetail.text
      )
      self.view?.display(model: viewModel)
    }
  }
}
