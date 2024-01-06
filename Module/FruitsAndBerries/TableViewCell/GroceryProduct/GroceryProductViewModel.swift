//
//  GroceryProductViewModel.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation
import UIKit.UIColor

struct GroceryProductViewModel {
  let title: String
  let iconPath: URL?
  let mainColor: UIColor?
  
  var textColor: UIColor? {
    return UIColor(hex: "#FFFFFF")
  }
  
}
