//
//  DetailViewController.swift
//  SamplePlayer
//
//  Created by CHATCHAI LOKNIYOM on 2018/05/26.
//  Copyright © 2018 Chatchai. All rights reserved.
//

import UIKit
import Kingfisher
import YouTubePlayer
import XCGLogger

/// Detail view controller, display video detail and allow playback.
class DetailViewController: BaseViewController {
    
    struct Constants {
        static let detailViewController: String = "DetailViewController"
        static let contentSizeHeightSpace: CGFloat = 44
    }
    
    //--------------------------------------------------
    // MARK:- Variables
    //--------------------------------------------------
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    /// Playlist item object. Must not be nil.
    var playlistItem: YoutubeItem!
    /// Video ID from playlist item
    var videoId: String {
        return playlistItem.contentDetails.videoId ?? GlobalConstants.String.empty
    }
    
    /// Instantiate DetailViewController
    ///
    /// - Parameter playlistItem: YoutubeItem of playlist item
    /// - Returns: DetailViewController
    static func instantiate(playlistItem: YoutubeItem) -> DetailViewController {
        let viewController = UIStoryboard.init(name: Constants.detailViewController, bundle: nil).instantiateViewController(withIdentifier: Constants.detailViewController) as! DetailViewController
        
        viewController.playlistItem = playlistItem
        
        return viewController
    }
    
    //--------------------------------------------------
    // MARK:- Lifecycles
    //--------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        setContentHeight()
    }
    
    //--------------------------------------------------
    // MARK:- Functions
    //--------------------------------------------------
    
    /// Configure view on loaded
    private func configureView() {
        
        navigationItem.title = playlistItem.snippet.title
        
        // Texts
        titleLabel.text = playlistItem.snippet.title
        publishedAtLabel.text = playlistItem.snippet.publishedAtYYYYMMDDHHMM
        descriptionTextView.text = playlistItem.snippet.description
        
        // Thumbnail image
        if let maxresThumbnailUrl = playlistItem.snippet.thumbnails.maxresThumbnail?.url,
            let url = URL(string: maxresThumbnailUrl) {
            videoImageView.kf.indicatorType = .activity
            videoImageView.kf.setImage(with: url)
        }
        
        // Setup video player
        videoPlayer.delegate = self
        videoPlayer.loadVideoID(videoId)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    /// Set content height of the scroll view
    private func setContentHeight() {
        
        // Adjust scrollview contentSize
        let contentHeight: CGFloat = titleLabel.frame.height + publishedAtLabel.frame.height + descriptionTextView.contentSize.height + Constants.contentSizeHeightSpace
        descriptionScrollView.contentSize = CGSize(width: descriptionScrollView.contentSize.width, height: contentHeight)
        XCGLogger.debug("Content Height: \(contentHeight)")
    }
}

// MARK: - YouTubePlayerDelegate
extension DetailViewController: YouTubePlayerDelegate {
    
    /// Player is ready to play
    ///
    /// - Parameter videoPlayer: YouTubePlayerView
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        
        // Hide network indicator and show the player
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        UIView.animate(withDuration: GlobalConstants.Value.animationDuration) {
            self.videoPlayer.alpha = 1.0
        }
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        
        // Set content height to correct layout after returning from fullscreen.
        setContentHeight()
    }
}
