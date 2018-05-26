//
//  YoutubeItemCell.swift
//  SamplePlayer
//
//  Created by CHATCHAI LOKNIYOM on 2018/05/26.
//  Copyright © 2018 Chatchai. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

/// Custom cell of youtube item (playlist and playlistItem)
class YoutubeItemCell: UITableViewCell {
    
    @IBOutlet weak var playlistImageView: UIImageView!
    @IBOutlet weak var playlistNameLabel: UILabel!
    @IBOutlet weak var playlistPublishedDateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistImageView.image = nil
    }
    
    /// Configure cell elements with youtube item
    ///
    /// - Parameter youtubeItem: YoutubeItem
    func configureCell(youtubeItem: YoutubeItem) {
        
        if let mediumThumbnailUrl = youtubeItem.snippet.thumbnails.mediumThumbnail?.url,
            let url = URL(string: mediumThumbnailUrl) {
            playlistImageView.kf.indicatorType = .activity
            playlistImageView.kf.setImage(with: url)
        }
        
        playlistNameLabel.text = youtubeItem.snippet.title
        playlistPublishedDateLabel.text = youtubeItem.snippet.publishedAtYYYYMMDD
        
    }
}
