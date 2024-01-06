//
//  ActivityIndicatorView.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import UIKit

protocol LoaderView {
  func startAnimation()
  func stopAnimation()
}

class ActivityIndicatorView: UIView, LoaderView {
  
  private lazy var indicatorImageView: UIImageView = .init() &> {
    $0.image = UIImage(named: "ic_loader")
    $0.contentMode = .scaleAspectFit
  }
  
  override var tintColor: UIColor! {
    didSet {
      indicatorImageView.tintColor = tintColor
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - LoaderView
  
  func startAnimation() {
    let rotation = CABasicAnimation(keyPath: "transform.rotation")
    rotation.fromValue = 0
    rotation.toValue = 2 * Double.pi
    rotation.duration = 1.0
    rotation.repeatCount = .infinity
    
    indicatorImageView.layer.add(rotation, forKey: rotation.keyPath)
  }
  
  func stopAnimation() {
    indicatorImageView.layer.removeAllAnimations()
  }
  
  // MARK: - Private
  
  private func setupUI() {
    addSubview(indicatorImageView)
    indicatorImageView.snp.makeConstraints { make in
      make.leading.equalTo(self.snp.leading)
      make.top.equalTo(self.snp.top)
      make.trailing.equalTo(self.snp.trailing)
      make.bottom.equalTo(self.snp.bottom)
    }
  }
  
}
