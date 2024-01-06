//
//  AppNavigationController.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import UIKit

class AppNavigationController: UINavigationController {
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    topViewController?.preferredStatusBarStyle ?? .default
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var textColor: UIColor = .white
  var mainColor: UIColor = .systemPink
  
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupApprearance()
  }
  
  func setupApprearance() {
    let barAppearance = UINavigationBarAppearance()
    
    let titleTextAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: textColor,
      .font: UIFont.systemFont(ofSize: 24, weight: .medium)
    ]
    barAppearance.titleTextAttributes = titleTextAttributes
    barAppearance.configureWithOpaqueBackground()
    barAppearance.backgroundColor = mainColor
    
    let buttonAppearance = UIBarButtonItemAppearance()
    buttonAppearance.normal.titleTextAttributes = titleTextAttributes
    barAppearance.buttonAppearance = buttonAppearance
    navigationBar.tintColor = textColor
    
    navigationBar.standardAppearance = barAppearance
    navigationBar.scrollEdgeAppearance = barAppearance
    navigationBar.compactAppearance = barAppearance
    navigationBar.compactScrollEdgeAppearance = barAppearance
  }
  
}
