//
//  BaseResponse.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 14/09/23.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let status: String?
    let message: T?
    let error: String?
}
