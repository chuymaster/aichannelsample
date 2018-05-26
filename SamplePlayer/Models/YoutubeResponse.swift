//
//  Playlist.swift
//  SamplePlayer
//
//  Created by CHATCHAI LOKNIYOM on 2018/05/26.
//  Copyright © 2018 Chatchai. All rights reserved.
//

import Foundation
import Himotoki

/// JSON decodable protocol
protocol DecodableModel: Himotoki.Decodable {
    
}

/// Youtube response model
struct YoutubeResponse: DecodableModel {
    
    let kind: String
    let etag: String
    let pageInfo: YoutubePageInfo
    let items: [YoutubeItem]
    
    static func decode(_ e: Extractor) throws -> YoutubeResponse {
        return try YoutubeResponse(kind: e <| "kind",
                            etag: e <| "etag",
                            pageInfo: e <| "pageInfo",
                            items: e <|| "items")
    }
}

/// Youtube page info model
struct YoutubePageInfo: DecodableModel {
    let totalResults: Int
    let resultsPerPage: Int
    
    static func decode(_ e: Extractor) throws -> YoutubePageInfo {
        return try YoutubePageInfo(totalResults: e <| "totalResults",
                                    resultsPerPage: e <| "resultsPerPage")
    }
    
}

/// Youtube item model
struct YoutubeItem: DecodableModel {
    
    let kind: String
    let etag: String
    let id: String
    let snippet: Snippet
    let contentDetails: ContentDetails
    
    static func decode(_ e: Extractor) throws -> YoutubeItem {
        return try YoutubeItem(kind: e <| "kind",
                                etag: e <| "etag",
                                id: e <| "id",
                                snippet: e <| "snippet",
                                contentDetails: e <| "contentDetails")
    }
}

/// Snippet model
struct Snippet: DecodableModel {
    
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: SnippetThumbnails
    let channelTitle: String
    
    /// Published at date in yyyy/MM/dd
    var publishedAtYYYYMMDD: String {
        if let publishedAtDate = DateUtilities.convertIsoDateStringToDate(dateString: publishedAt) {
            return DateUtilities.formatDateToString(date: publishedAtDate, format: DateUtilities.Formats.yyyyMMddSlash)
        } else {
            return GlobalConstants.String.empty
        }
    }
    
    /// /// Published at date in yyyy/MM/dd HH:mm
    var publishedAtYYYYMMDDHHMM: String {
        if let publishedAtDate = DateUtilities.convertIsoDateStringToDate(dateString: publishedAt) {
            return DateUtilities.formatDateToString(date: publishedAtDate, format: DateUtilities.Formats.yyyyMMddHHmmSlash)
        } else {
            return GlobalConstants.String.empty
        }
    }
    
    static func decode(_ e: Extractor) throws -> Snippet {
        return try Snippet(publishedAt: e <| "publishedAt",
                                       channelId: e <| "channelId",
                                       title: e <| "title",
                                       description: e <| "description",
                                       thumbnails: e <| "thumbnails",
                                       channelTitle: e <| "channelTitle"
        )
    }
    
}

/// Snippet thumbnails model
struct SnippetThumbnails: DecodableModel {
    
    let defaultThumbnail: SnippetThumbnailDetail?
    let mediumThumbnail: SnippetThumbnailDetail?
    let highThumbnail: SnippetThumbnailDetail?
    let standardThumbnail: SnippetThumbnailDetail?
    let maxresThumbnail: SnippetThumbnailDetail?

    static func decode(_ e: Extractor) throws -> SnippetThumbnails {
        return try SnippetThumbnails(defaultThumbnail: e <|? "default",
                                                mediumThumbnail: e <|? "medium",
                                                highThumbnail: e <|? "high",
                                                standardThumbnail: e <|? "standard",
                                                maxresThumbnail: e <|? "maxres")
    }
}

/// Snippet thumbnail detail
struct SnippetThumbnailDetail: DecodableModel {
    
    let url: String
    let width: Int
    let height: Int
    
    static func decode(_ e: Extractor) throws -> SnippetThumbnailDetail {
        return try SnippetThumbnailDetail(url: e <| "url",
                                          width: e <| "width",
                                          height: e <| "height")
    }
}

/// Content details
struct ContentDetails: DecodableModel {
    
    let itemCount: Int?
    let videoId: String?
    let videoPublishedAt: String?
    
    static func decode(_ e: Extractor) throws -> ContentDetails {
        return try ContentDetails(itemCount: e <|? "itemCount",
                                              videoId: e <|? "videoId",
                                              videoPublishedAt: e <|? "videoPublishedAt" )
    }
}
