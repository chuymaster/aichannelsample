//
//  ApiError.swift
//  SamplePlayer
//
//  Created by CHATCHAI LOKNIYOM on 2018/05/26.
//  Copyright © 2018 Chatchai. All rights reserved.
//

import Foundation
import Alamofire

/// API Error
///
/// - communicationError: communication error
/// - castedError: json data casting error
/// - decodeError: json data decode error
/// - unknownError: unknown error
enum ApiError: CustomNSError {
    
    case communicationError(error: AFError)
    case castedError
    case decodeError
    case unknownError(error: Error)
    
    /// Localized description of each error
    var localizedDescription: String {
        switch self {
        case .communicationError(let error):
            switch error {
            case .invalidURL(let url):
                return "Invalid URL: \(url) - \(error.localizedDescription)"
            case .parameterEncodingFailed(let reason):
                return """
Parameter encoding failed: \(error.localizedDescription)
Failure Reason: \(reason)
"""
            case .multipartEncodingFailed(let reason):
                return """
Multipart encoding failed: \(error.localizedDescription)
Failure Reason: \(reason)
"""
            case .responseValidationFailed(let reason):
                return """
Response validation failed: \(error.localizedDescription)
Failure Reason: \(reason)
"""
            case .responseSerializationFailed(let reason):
                return """
Response serialization failed: \(error.localizedDescription)
Failure Reason: \(reason)
"""
            }
        case .unknownError(let error):
            return error.localizedDescription
        default:
            return "Data is corrupted"
        }
    }
}
