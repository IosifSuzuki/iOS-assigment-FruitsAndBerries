//
//  UITableView+Extension.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import UIKit

extension UITableView {
  
  func registerHeaderFooter<T: UITableViewHeaderFooterView>(forClass classInstance: T.Type) {
    let nibCell = UINib(nibName: classInstance.identifier, bundle: .main)
    register(nibCell, forHeaderFooterViewReuseIdentifier: classInstance.identifier)
  }
  
  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(forClass classInstance: T.Type) -> T {
    guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: classInstance.identifier) as? T else {
      preconditionFailure()
    }
    
    return headerFooterView
  }
  
  func registerCell<T: UITableViewCell>(forClass classInstance: T.Type) {
    register(classInstance, forCellReuseIdentifier: classInstance.identifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(forClass classInstance: T.Type, indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: classInstance.identifier, for: indexPath) as? T else {
      preconditionFailure()
    }
    
    return cell
  }
  
}

extension UITableViewHeaderFooterView: Identify { }
extension UITableViewCell: Identify { }
