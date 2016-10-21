//
//  LZRequest.swift
//  LZRequest
//
//  Created by 王渊鸥 on 2016/10/21.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public struct LZRequest {
	var session:URLSession
	var request:URLRequest
}

public extension LZRequest {
	func array(_ response:@escaping ([Any]?)->Void) {
		self.session.dataTask(with: request) { (data, resp, error) in
			if let data = data {
				if let json = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments) ) as? [Any] {
					OperationQueue.main.addOperation { response(json) }
				} else {
					print("Json array parser error: \(data)")
					OperationQueue.main.addOperation { response(nil) }
				}
			} else {
				print("Request error: \(resp)")
				OperationQueue.main.addOperation { response(nil) }
			}
		}.resume()
	}
	
	func dictionary(_ response:@escaping ([AnyHashable:Any]?)->Void) {
		self.session.dataTask(with: request) { (data, resp, error) in
			if let data = data {
				if let json = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments) ) as? [AnyHashable:Any] {
					OperationQueue.main.addOperation { response(json) }
				} else {
					print("Json array parser error: \(data)")
					OperationQueue.main.addOperation { response(nil) }
				}
			} else {
				print("Request error: \(resp)")
				OperationQueue.main.addOperation { response(nil) }
			}
			}.resume()
	}
	
	func string(_ response:@escaping (String?)->Void) {
		self.session.dataTask(with: request) { (data, resp, error) in
			if let data = data {
				if let text = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as? String {
					OperationQueue.main.addOperation { response(text) }
				} else {
					print("String parse error: \(data)")
					OperationQueue.main.addOperation { response(nil) }
				}
			} else {
				print("Request error: \(resp)")
				OperationQueue.main.addOperation { response(nil) }
			}
			}.resume()
	}
	
	func data(_ response:@escaping (Data?)->Void) {
		self.session.dataTask(with: request) { (data, resp, error) in
			if let data = data {
				OperationQueue.main.addOperation { response(data) }
			} else {
				print("Request error: \(resp)")
				OperationQueue.main.addOperation { response(nil) }
			}
			}.resume()
	}
}