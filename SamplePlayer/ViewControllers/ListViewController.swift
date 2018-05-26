//
//  ViewController.swift
//  SamplePlayer
//
//  Created by CHATCHAI LOKNIYOM on 2018/05/26.
//  Copyright © 2018 Chatchai. All rights reserved.
//

import UIKit
import XCGLogger

/// List view controller. Display youtube response items in tableView list
class ListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Constants {
        static let title = "A.I.Channel"
        static let youtubeItemCellIdentifier = "YoutubeItemCell"
        static let listViewController = "ListViewController"
        static let playlistItemListViewController = "PlaylistItemListViewController"
    }
    
    //--------------------------------------------------
    // MARK:- Variables
    //--------------------------------------------------
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshBarButtonItem: UIBarButtonItem!
    
    /// Request ID for Youtube API request parameter
    var requestId: String = GlobalConstants.Id.aiChannelId
    /// Title text of the view controller
    var titleText: String = Constants.title
    /// Response from Youtube API
    var youtubeResponse: YoutubeResponse? {
        didSet {
            tableView?.reloadData()
        }
    }
    /// Tableview pull-to-refresh control
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(self.getYoutubeData(_:)),
                                 for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()

    //--------------------------------------------------
    // MARK:- Lifecycles
    //--------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    //--------------------------------------------------
    // MARK:- Actions
    //--------------------------------------------------
    
    @IBAction func tapRefresh(_ sender: Any) {
        getYoutubeData()
    }
    
    //--------------------------------------------------
    // MARK:- Functions
    //--------------------------------------------------
    
    /// Configure view on loaded
    func configureView() {
        tableView.addSubview(refreshControl)
        navigationItem.title = titleText
    }
    
    
    /// Get youtube data from API
    ///
    /// - Parameter refreshControl: UIRefreshControl, if called from pull-to-refresh
    @objc func getYoutubeData(_ refreshControl: UIRefreshControl? = nil) {
        
        if refreshControl == nil {
            showOnWindow()
        }
        // Clear data
        youtubeResponse = nil
        
        // Do data request in subclass
    }
    
    //--------------------------------------------------
    // MARK:- ApiClientHelperDelegate
    //--------------------------------------------------
    
    override func didCompleteWithError(error: ApiError) {
        super.didCompleteWithError(error: error)
        refreshControl.endRefreshing()
    }
    
    //--------------------------------------------------
    // MARK:- UITableViewDataSource
    //--------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youtubeResponse?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let youtubeItemCell = tableView.dequeueReusableCell(withIdentifier: Constants.youtubeItemCellIdentifier, for: indexPath) as? YoutubeItemCell,
            let playlistItems = youtubeResponse?.items else {
                return UITableViewCell()
        }
        
        youtubeItemCell.configureCell(youtubeItem: playlistItems[indexPath.row])
        return youtubeItemCell
        
    }
    
    //--------------------------------------------------
    // MARK:- UITableViewDelegate
    //--------------------------------------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        fatalError("\(#function) must be overridden in subclass)")
    }

    
}
