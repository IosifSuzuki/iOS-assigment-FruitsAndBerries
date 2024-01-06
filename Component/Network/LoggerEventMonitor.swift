//
//  LoggerEventMonitor.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation
import Alamofire

final class LoggerEventMonitor: EventMonitor {
  
  func requestDidResume(_ request: Request) {
    request.cURLDescription { (description) in
      print("\(request.description)\n\(description)")
    }
  }
  
  func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
    if let error = response.error {
      print("failed request \(request.description): \(error.localizedDescription)" )
    } else {
      print("successed request: \(request.description)")
    }
    
    if let degubResponseString = response.data?.prettyJSONString {
      print("response data: \n\(degubResponseString)")
    }
  }
  
}
