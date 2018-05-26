//
//  AppDelegate.swift
//  SamplePlayer
//
//  Created by CHATCHAI LOKNIYOM on 2018/05/26.
//  Copyright © 2018 Chatchai. All rights reserved.
//

import UIKit
import AVFoundation
import XCGLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let log = XCGLogger.default
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Setup the logger
        log.setup(level: .debug, showFunctionName: true, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, showDate: true)
        
        // Set the audio session to media playback
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            log.info("Setting category to AVAudioSessionCategoryPlayback succeeded.")
        } catch {
            log.warning("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        return true
    }

}

