//
//  FruitsAndBerriesDetailsViewController.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 07.01.2024.
//

import UIKit

final class FruitsAndBerriesDetailsViewController: BaseViewController {
  
  private var cardView: UIView = .init() &> {
    $0.layer.cornerRadius = 12
    $0.layer.masksToBounds = true
  }
  
  private lazy var iconImageView: UIImageView = .init() &> {
    $0.contentMode = .scaleAspectFit
  }
  
  private lazy var textLabel: UILabel = .init() &> {
    $0.font = UIFont.systemFont(ofSize: 26, weight: .regular)
    $0.textColor = UIColor(hex: "#FFFFFF")
    $0.numberOfLines = 0
    $0.textAlignment = .left
  }
  
  private var downloader: Downloader?
  
  var interactor: FruitsAndBerriesBusinessLogic?
  var router: FruitsAndBerriesRoutingLogic?
  
  // MARK: - Override
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let request = FruitsAndBerriesModels.LoadDetail.Request()
    interactor?.loadDetail(request: request)
  }
  
  deinit {
    downloader?.cancel()
  }
  
  override func loadView() {
    super.loadView()
    
    view = UIView()
    
    view.addSubview(cardView)
    cardView.snp.makeConstraints { make in
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(32)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-32)
      make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
    }
    
    iconImageView.snp.makeConstraints { make in
      make.height.equalTo(100)
      make.height.equalTo(iconImageView.snp.width)
    }
    
    let cardStackView: UIStackView = .init() &> {
      $0.axis = .vertical
      $0.spacing = 16
      $0.alignment = .center
    }
    
    cardStackView.addArrangedSubview(iconImageView)
    cardStackView.addArrangedSubview(textLabel)
    
    cardView.addSubview(cardStackView)
    cardStackView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(16)
      make.top.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.bottom.equalToSuperview().offset(-16)
    }
    
  }
  
  // MARK: - Private
  
  private func set(imagePath: URL?) {
    iconImageView.isHidden = imagePath == nil
    cardView.setNeedsLayout()
    cardView.layoutIfNeeded()
    
    guard let imagePath else {
      iconImageView.image = nil
      return
    }
    
    let dataDownloader = DataDownloader()
    self.downloader = dataDownloader
    dataDownloader.fetch(by: imagePath) { [weak self] result in
      guard let self else {
        return
      }
      
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          UIView.transition(with: self.iconImageView, duration: 0.2, options: .transitionCrossDissolve) { [weak self] in
            self?.iconImageView.image = UIImage(data: data)
          }
        }
      case .failure(let error):
        iconImageView.isHidden = true
        cardView.setNeedsLayout()
        cardView.layoutIfNeeded()
        
        let request = FruitsAndBerriesModels.Alert.Request(error: error)
        self.interactor?.alert(request: request)
      }
    }
    dataDownloader.resume()
  }
}

extension FruitsAndBerriesDetailsViewController: FruitsAndBerriesDisplayLogic {
  
  func display(model: FruitsAndBerriesModels.LoadDetail.ViewModel) {
    title = model.title
    textLabel.text = model.text
    cardView.backgroundColor = model.color
    set(imagePath: model.iconPath)
  }
  
  func display(model: FruitsAndBerriesModels.Loading.ViewModel) {
    model.isLoading ? startAnimation() : stopAnimation()
  }
  
  func display(model: FruitsAndBerriesModels.Alert.ViewModel) {
    stopAnimation()
    
    showAlert(title: model.title, message: model.message)
  }
  
  func display(model: FruitsAndBerriesModels.Load.ViewModel) { }
  
  func display(model: FruitsAndBerriesModels.SelectItem.ViewModel) { }
  
}
