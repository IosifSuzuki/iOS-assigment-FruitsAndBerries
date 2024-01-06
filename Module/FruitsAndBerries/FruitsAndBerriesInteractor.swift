//
//  FruitsAndBerriesInteractor.swift
//  iOS-Test
//

import Foundation

// Implemented by Interactor
protocol FruitsAndBerriesBusinessLogic {
  // Loads the list of the items and passes Load.Response to Presenter
  func load(request: FruitsAndBerriesModels.Load.Request)
}

final class FruitsAndBerriesInteractor {
  var presenter: FruitsAndBerriesPresentationLogic?
  let api: API
  
  init(api: API) {
    self.api = api
  }
  
  // MARK: - Private
  
  private func playLoadingAnimation(_ isLoading: Bool) {
    let response = FruitsAndBerriesModels.Loading.Response(isLoading: isLoading)
    
    self.presenter?.present(response: response)
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
        playLoadingAnimation(false)
        self.presenter?.present(response: response)
      } catch {
        let title = "Network error"
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
  }
  
}
