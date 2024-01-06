//
//  GroceryProductTableViewCell.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import UIKit

final class GroceryProductTableViewCell: UITableViewCell {
  
  var mainColor: UIColor? {
    didSet {
      rootView.backgroundColor = mainColor
    }
  }
  
  var textColor: UIColor? {
    didSet {
      titleLabel.textColor = textColor
    }
  }
  
  var text: String? {
    didSet {
      titleLabel.text = text
    }
  }
  
  private lazy var rootView: UIView = .init() &> {
    $0.backgroundColor = .clear
    $0.layer.cornerRadius = 12
    $0.layer.masksToBounds = true
  }
  
  private(set) lazy var titleLabel: UILabel = .init() &> {
    $0.font = .systemFont(ofSize: 20, weight: .regular)
    $0.numberOfLines = .zero
  }
  
  private(set) lazy var iconImage: UIImageView = .init() &> {
    $0.contentMode = .scaleAspectFit
  }
  
  private var downloader: Downloader = DataDownloader()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    iconImage.image = nil
    downloader.cancel()
  }
  
  // MARK: - Internal
  
  func icon(with url: URL?) {
    downloader.cancel()
  
    guard let url else {
      iconImage.image = nil
      return
    }
    
    downloader.fetch(by: url) { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          self?.set(image: UIImage(data: data))
        }
      case .failure(let error):
        print(error)
      }
    }
    
    downloader.resume()
  }
  
  // MARK: - Private
  
  private func setupView() {
    selectionStyle = .none
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    
    iconImage.snp.makeConstraints { make in
      make.height.equalTo(iconImage.snp.width)
    }
    
    let rootStackView: UIStackView = .init() &> {
      $0.axis = .horizontal
      $0.alignment = .fill
      $0.distribution = .equalSpacing
      $0.addArrangedSubview(titleLabel)
      $0.addArrangedSubview(iconImage)
    }
    
    rootView.addSubview(rootStackView)
    
    rootStackView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(16)
      make.top.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.bottom.equalToSuperview().offset(-16)
    }
    
    contentView.addSubview(rootView)
    
    rootView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(32)
      make.top.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-32)
      make.bottom.equalToSuperview().offset(-16)
    }
  }
  
  private func set(image: UIImage?) {
    guard let image else {
      self.iconImage.image = nil
      return
    }
    
    UIView.transition(with: iconImage, duration: 0.2, options: .transitionCrossDissolve) { [weak self] in
      self?.iconImage.image = image
    }
  }
}
