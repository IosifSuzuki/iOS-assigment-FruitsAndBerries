//
//  FruitsAndBerriesInteractor.swift
//  iOS-Test
//

import Foundation

// Implemented by Interactor
protocol FruitsAndBerriesBusinessLogic {
  // Loads the list of the items and passes Load.Response to Presenter
  func load(request: FruitsAndBerriesModels.Load.Request)
  func select(request: FruitsAndBerriesModels.SelectItem.Request)
  func loadDetail(request: FruitsAndBerriesModels.LoadDetail.Request)
  func alert(request: FruitsAndBerriesModels.Alert.Request)
}

final class FruitsAndBerriesInteractor {
  var presenter: FruitsAndBerriesPresentationLogic?
  
  private let api: API
  private var selectedIndexPath: IndexPath?
  private var dataSource: [GroceryProduct] = []
  
  init(api: API) {
    self.api = api
  }
  
  // MARK: - Private
  
  private func playLoadingAnimation(_ isLoading: Bool) {
    let response = FruitsAndBerriesModels.Loading.Response(isLoading: isLoading)
    
    self.presenter?.present(response: response)
  }
  
  private func show(title: String, error: Error) {
    let message: String
    switch error {
    case let error as LocalizedError:
      message = error.errorDescription ?? error.localizedDescription
    default:
      message = error.localizedDescription
    }
    
    let response = FruitsAndBerriesModels.Alert.Response(title: title, message: message)
    presenter?.present(response: response)
  }
}

extension FruitsAndBerriesInteractor: FruitsAndBerriesBusinessLogic {
  
  func load(request: FruitsAndBerriesModels.Load.Request) {
    Task { [weak self] in
      guard let self else {
        return
      }
      
      do {
        playLoadingAnimation(true)
        let grosary = try await self.api.fetchGrosary()
        
        let response = FruitsAndBerriesModels.Load.Response(title: grosary.title, items: grosary.items)
        self.dataSource = response.items
        
        playLoadingAnimation(false)
        self.presenter?.present(response: response)
        
      } catch {
        self.show(title: "Network error", error: error)
      }
    }
  }
  
  func loadDetail(request: FruitsAndBerriesModels.LoadDetail.Request) {
    Task { [weak self] in
      guard let self, let selectedIndexPath else {
        return
      }
      
      let grocaryProduct = self.dataSource[selectedIndexPath.row]
      let selectedID = self.dataSource[selectedIndexPath.row].id
      do {
        playLoadingAnimation(true)
        let groceryProductDetail = try await api.fetchGrosaryProduct(by: selectedID)
        
        let response = FruitsAndBerriesModels.LoadDetail.Response(
          groceryProduct: grocaryProduct,
          groceryProductDetail: groceryProductDetail
        )
        
        self.presenter?.present(response: response)
        playLoadingAnimation(false)
        
      } catch {
        self.show(title: "Network error", error: error)
      }
      
    }
  }
  
  func select(request: FruitsAndBerriesModels.SelectItem.Request) {
    selectedIndexPath = request.indexPath
    
    presenter?.present(response: .init(id: ""))
  }
  
  func alert(request: FruitsAndBerriesModels.Alert.Request) {
    show(title: "Error", error: request.error)
  }
  
}
