//
//  PlaylistItemListViewController.swift
//  SamplePlayer
//
//  Created by CHATCHAI LOKNIYOM on 2018/05/26.
//  Copyright © 2018 Chatchai. All rights reserved.
//

import Foundation
import UIKit
import XCGLogger

/// Playlist item list view controller, display playlist items of the playlist
class PlaylistItemListViewController: ListViewController {
    
    /// Instantiate PlaylistItemListViewController
    ///
    /// - Parameters:
    ///   - playlistId: playlist id of the playlist items
    ///   - title: playlist title
    ///   - playlistItems: YoutubeResponse of playlist items
    /// - Returns: PlaylistItemListViewController
    static func instantiate(playlistId: String,
                            title: String,
                            playlistItems: YoutubeResponse) -> PlaylistItemListViewController {
        let viewController = UIStoryboard.init(name: Constants.listViewController, bundle: nil).instantiateViewController(withIdentifier: Constants.playlistItemListViewController) as! PlaylistItemListViewController
        
        viewController.requestId = playlistId
        viewController.titleText = title
        viewController.youtubeResponse = playlistItems
        
        return viewController
    }

    
    override func getYoutubeData(_ refreshControl: UIRefreshControl?) {
        super.getYoutubeData()
        
        apiClientHelper.getPlaylistItems(playlistId: requestId) { [unowned self] (playlistItem) in
            
            self.youtubeResponse = playlistItem
            self.hideLoadingHubFromKeyWindow()
            self.refreshControl.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let playlistItems = youtubeResponse?.items else {
            return
        }
        
        let playlistItem = playlistItems[indexPath.row]
        XCGLogger.debug("Selected playlist item ID: \(playlistItem.id)")
        
        // Navigate to DetailViewController
        let detailViewController = DetailViewController.instantiate(playlistItem: playlistItem)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
