//
//  GlobalConstants.swift
//  SamplePlayer
//
//  Created by CHATCHAI LOKNIYOM on 2018/05/26.
//  Copyright © 2018 Chatchai. All rights reserved.
//

import Foundation
import UIKit

/// Globally accessible constants
struct GlobalConstants {

    /// Youtube Data API Key. Please get one from https://developers.google.com/youtube/v3/getting-started
    static let youtubeApiKey = "AIzaSyBDk9Xl6y81cQp_lp9yZmobtmS6KKGxbas"
    
    struct ApiUrl {
        /// Base API URL of youtube data API
        private static let youtubeBaseApi = "https://www.googleapis.com/youtube/v3/"
        /// playlists API
        static let playlists = youtubeBaseApi + "playlists"
        /// playlistItems API
        static let playlistItems = youtubeBaseApi + "playlistItems"
        
    }
    struct Id {
        /// A.I.Channel ID
        static let aiChannelId = "UC4YaOt1yT-ZeyB0OmxHgolA"
    }
    struct String {
        /// Empty string
        static let empty = ""
    }
    struct Value {
        /// View animation duration
        static let animationDuration: TimeInterval = TimeInterval(0.3)
    }
}
