//
//  Downloader.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation
import UIKit.UIImage

protocol Downloader {
  func fetch(by url: URL, closure: @escaping (Result<Data, ApplicationError>) -> Void)
  func cancel()
  func resume()
}
