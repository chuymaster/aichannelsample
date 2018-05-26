//
//  ApiClientHelper.swift
//  SamplePlayer
//
//  Created by CHATCHAI LOKNIYOM on 2018/05/26.
//  Copyright © 2018 Chatchai. All rights reserved.
//

import Foundation
import Alamofire

/// API Client helper delegate
protocol ApiClientHelperDelegate: class {
    
    /// Did complete API communication with error
    ///
    /// - Parameter error: ApiError
    func didCompleteWithError(error: ApiError)
}

/// API Client helper, perform communication tasks with API.
class ApiClientHelper {
    
    struct Constants {
        static let defaultPart: String = "snippet,contentDetails"
        static let defaultMaxResults: Int = 25
    }
    
    /// DataRequest reference for cancel
    weak var request: DataRequest?
    /// ApiClientHelperDelegate
    weak var delegate: ApiClientHelperDelegate?
    
    /// Initialize with delegate
    ///
    /// - Parameter delegate: ApiClientHelperDelegate
    required init(delegate: ApiClientHelperDelegate) {
        self.delegate = delegate
    }
    
    /// Cancel current request
    func cancelRequest() {
        request?.cancel()
    }
    
    /// Get channel playlists from API
    ///
    /// - Parameters:
    ///   - channelId: channel ID
    ///   - part: part to get
    ///   - maxResults: max result number to request
    ///   - completion: Nullable Playlist object
    func getPlaylists(channelId: String,
                      part: String = Constants.defaultPart,
                      maxResults: Int = Constants.defaultMaxResults,
                      completion:@escaping(_ playlist: YoutubeResponse?) -> Void) {
        
        let url = GlobalConstants.ApiUrl.playlists
        let parameter: [String: String] = [
            "channelId": channelId,
            "part": part,
            "maxResults": "\(maxResults)"
        ]
        
        getYoutubeResponse(url: url, parameter: parameter) { (responseDictionary) in
            
            do {
                let playlist: YoutubeResponse? = try YoutubeResponse.decodeValue(responseDictionary)
                DispatchQueue.main.async {
                    completion(playlist)
                }
            } catch {
                DispatchQueue.main.async {
                    self.delegate?.didCompleteWithError(error: ApiError.decodeError)
                }
            }
        }
    }
    
    /// Get playlist items from API
    ///
    /// - Parameters:
    ///   - playlistId: playlist ID
    ///   - part: part to get
    ///   - maxResults: max result number to request
    ///   - completion: Nullable Playlist object
    func getPlaylistItems(playlistId: String,
                          part: String = Constants.defaultPart,
                          maxResults: Int = Constants.defaultMaxResults,
                          completion:@escaping(_ playlistItem: YoutubeResponse?) -> Void) {
        
        let url = GlobalConstants.ApiUrl.playlistItems
        let parameter: [String: String] = [
            "playlistId": playlistId,
            "part": part,
            "maxResults": "\(maxResults)"
        ]
        
        getYoutubeResponse(url: url, parameter: parameter) { (responseDictionary) in
            
            do {
                let playlistItem: YoutubeResponse? = try YoutubeResponse.decodeValue(responseDictionary)
                DispatchQueue.main.async {
                    completion(playlistItem)
                }
            } catch {
                DispatchQueue.main.async {
                    self.delegate?.didCompleteWithError(error: ApiError.decodeError)
                }
            }
        }
    }
    
    /// Get response from Youtube API
    ///
    /// - Parameters:
    ///   - url: URL string
    ///   - parameter: request parameter dictionary
    ///   - completion: dictionary of request response data
    private func getYoutubeResponse(url: String,
                                    parameter: [String: String],
                                    completion:@escaping(_ responseDictionary: [String: Any]) -> Void) {
        
        var authorizedParameter: [String: String] =
            ["key": GlobalConstants.youtubeApiKey]
        authorizedParameter.merge(parameter) { (first, _) -> String in
            first
        }
        
        request = Alamofire.request(url, method: .get, parameters: authorizedParameter).responseJSON {
            (dataResponse) in
            
            switch dataResponse.result {
            case .success(let response):
                // Success
                
                if let responseDictionary = response as? [String: Any] {
                    completion(responseDictionary)
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.didCompleteWithError(error: ApiError.castedError)
                    }
                }
                
            case .failure(let error):
                // Failure
                
                if let afError = error as? AFError {
                    DispatchQueue.main.async {
                        self.delegate?.didCompleteWithError(error: ApiError.communicationError(error: afError))
                    }
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.didCompleteWithError(error: ApiError.unknownError(error: error))
                    }
                }
            }
        }
        
    }
}
