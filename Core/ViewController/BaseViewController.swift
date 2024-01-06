//
//  BaseViewController.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import UIKit

class BaseViewController: UIViewController, LoaderView {
  
  private lazy var activityIndicatorView: ActivityIndicatorView = .init() &> {
    $0.backgroundColor = .clear
  }
  
  private lazy var loaderView: UIView = .init() &> {
    $0.backgroundColor = UIColor(hex: "#FFFFFF")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  func setupUI() {
    view.backgroundColor = UIColor(hex: "#FFFFFF")
    
    activityIndicatorView.tintColor = .systemPink
  }
  
  // MARK: - LoaderView
  
  func startAnimation() {
    view.addSubview(loaderView)
    view.bringSubviewToFront(loaderView)
    loaderView.snp.makeConstraints { make in
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
    
    loaderView.addSubview(activityIndicatorView)
    activityIndicatorView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.height.equalTo(activityIndicatorView.snp.width)
      make.height.equalTo(100)
      make.top.equalTo(loaderView.snp.top).offset(30)
    }
    
    activityIndicatorView.startAnimation()
  }
  
  func stopAnimation() {
    activityIndicatorView.stopAnimation()
    
    loaderView.removeFromSuperview()
  }
  
  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAlert = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(okAlert)
    
    present(alertController, animated: true)
  }
}
