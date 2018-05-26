//
//  PlaylistListViewController.swift
//  SamplePlayer
//
//  Created by CHATCHAI LOKNIYOM on 2018/05/26.
//  Copyright © 2018 Chatchai. All rights reserved.
//


import Foundation
import UIKit
import XCGLogger

/// Playlist list view controller, display playlists of the channel
class PlaylistListViewController: ListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getYoutubeData(nil)
    }
    
    override func getYoutubeData(_ refreshControl: UIRefreshControl?) {
        super.getYoutubeData()
        
        apiClientHelper.getPlaylists(channelId: requestId) { [unowned self] (playlist) in
            self.youtubeResponse = playlist
            self.hideLoadingHubFromKeyWindow()
            self.refreshControl.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let items = youtubeResponse?.items else {
            return
        }
        
        let item = items[indexPath.row]
        XCGLogger.debug("Selected playlist ID: \(item.id)")
        showOnWindow()
        apiClientHelper.getPlaylistItems(playlistId: item.id) { [unowned self] (playlistItem) in
            
            self.hideLoadingHubFromKeyWindow()
            if let playlistItem = playlistItem {
                
                // Navigate to PlaylistItemListViewController
                let playlistItemListViewController =
                    PlaylistItemListViewController.instantiate(playlistId: item.id,
                                                               title: item.snippet.title ,
                                                               playlistItems: playlistItem)
                self.navigationController?.pushViewController(playlistItemListViewController, animated: true)
            }
        }
    }
}
