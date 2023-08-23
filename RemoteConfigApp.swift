//
//  RemoteConfigApp.swift
//  RemoteConfig
//
//  Created by Raihana on 8/15/23.
//

import SwiftUI
import FirebaseCore

@main
struct RemoteConfigApp: App {
    init(){
        RemoteConfigManager.sharedInstance.setup()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
