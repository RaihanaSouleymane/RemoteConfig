//
//  RemoteConfigManager.swift
//  RemoteConfig
//
//  Created by Raihana on 8/15/23.
//

import Foundation
import Firebase

class RemoteConfigManager {
  
  // MARK: Singleton
  
  static var sharedInstance = RemoteConfigManager()
  private init(){}
  
  // MARK: Config Keys
  
  enum Keys {
    static let showNewUI = "showNewUI"
    static let baseURLPath = "baseURLPath"
    static let configJson = "configJson"
  }
  
  var remoteConfig: RemoteConfig?
  var remoteConfigSettings: RemoteConfigSettings?
  var defaultRemoteConfigFile = "RemoteConfigDefaultValues"
  
  // MARK: Main Functions
  
  func setup() {
    FirebaseApp.configure()
      remoteConfig = RemoteConfig.remoteConfig()
      let settings = RemoteConfigSettings()
      settings.minimumFetchInterval = 0
      remoteConfig?.configSettings = settings
      remoteConfig?.setDefaults(fromPlist: defaultRemoteConfigFile)
  }
}
