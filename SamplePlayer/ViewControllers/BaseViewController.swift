//
//  BaseViewController.swift
//  SamplePlayer
//
//  Created by CHATCHAI LOKNIYOM on 2018/05/26.
//  Copyright © 2018 Chatchai. All rights reserved.
//

import UIKit
import XCGLogger
import RSLoadingView

/// The base view controller
class BaseViewController: UIViewController, ApiClientHelperDelegate {

    struct Constants {
        static let errorTitle = "Error"
        static let okTitle = "OK"
    }
    
    lazy var apiClientHelper: ApiClientHelper = ApiClientHelper(delegate: self)
    
    /// Show error dialog with ok button to dismiss.
    ///
    /// - Parameters:
    ///   - title: dialog title
    ///   - message: dialog message
    func showErrorDialog(title: String? = Constants.errorTitle, message: String?) {
        XCGLogger.error(message ?? GlobalConstants.String.empty)
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: Constants.okTitle , style: .default, handler: nil)
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true, completion: nil)
    }
    
    //--------------------------------------------------
    // MARK:- RSLoadingView default methods
    //--------------------------------------------------
    
    @IBAction func showLoadingHub() {
        let loadingView = RSLoadingView()
        loadingView.show(on: view)
    }
    
    @IBAction func showOnViewTwins() {
        let loadingView = RSLoadingView(effectType: RSLoadingView.Effect.twins)
        loadingView.show(on: view)
    }
    
    func hideLoadingHub() {
        RSLoadingView.hide(from: view)
    }
    
    @IBAction func showOnWindow() {
        let loadingView = RSLoadingView()
        loadingView.showOnKeyWindow()
    }
    
    func hideLoadingHubFromKeyWindow() {
        RSLoadingView.hideFromKeyWindow()
    }
    
    //--------------------------------------------------
    // MARK:- ApiClientHelperDelegate
    //--------------------------------------------------
    
    /// Did complete API communication with error
    ///
    /// - Parameter error: ApiError
    func didCompleteWithError(error: ApiError) {
        hideLoadingHub()
        hideLoadingHubFromKeyWindow()
        showErrorDialog(message: error.localizedDescription)
    }
}
