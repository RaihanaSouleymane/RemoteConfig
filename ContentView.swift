//
//  ContentView.swift
//  RemoteConfig
//
//  Created by Raihana on 8/15/23.
//

import SwiftUI
/*
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
    
    
    func fetch(){
      
        
        RemoteConfigManager.sharedInstance.remoteConfig?.fetch { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
              RemoteConfigManager.sharedInstance.remoteConfig?.activate { changed, error in
              // ...
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
        
        }
        
        
        
          
          // fetch and activate config values
        RemoteConfigManager.sharedInstance.remoteConfig?.fetch(withExpirationDuration: 0.5, completionHandler: { [unowned self] (status, error) in
            RemoteConfigManager.sharedInstance.remoteConfig?.activate()
            
              self.question = RemoteConfigManager.sharedInstance.remoteConfig?.configValue(forKey: RemoteConfigManager.Keys.showNewUI).boolValue
            self.answer   = RemoteConfigManager.sharedInstance.remoteConfig?.configValue(forKey: RemoteConfigManager.Keys.baseURLPath).stringValue
          })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/


import Firebase

struct ContentView: View {
    @State private var baseURL: String = "Loading..."
    @State private var showNewUI: Bool = false
    @State private var newUIColor: String = ""
    
    //#800080 purple hex

    var body: some View {
        ZStack {
            Color.purple
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(baseURL)
                    .padding()
                
                Button("Fetch from FireBase") {
                    fetchRemoteConfig()
                }
                .padding()
            } .background(showNewUI ? Color(hex: newUIColor) : Color.white)
        }
        .onAppear(perform: fetchRemoteConfig)
    }
    
    func fetchRemoteConfig() {
        RemoteConfigManager.sharedInstance.remoteConfig?.fetch { (status, error) in
            if status == .success {
                RemoteConfigManager.sharedInstance.remoteConfig?.activate { (changed, error) in
                    let fetchedMessage = RemoteConfigManager.sharedInstance.remoteConfig?.configValue(forKey: RemoteConfigManager.Keys.baseURLPath).stringValue
                    self.baseURL = fetchedMessage ?? "Test"
                    self.showNewUI = RemoteConfigManager.sharedInstance.remoteConfig?.configValue(forKey: RemoteConfigManager.Keys.showNewUI).boolValue ?? false
                    
                    if  let configJson = RemoteConfigManager.sharedInstance.remoteConfig?.configValue(forKey: RemoteConfigManager.Keys.configJson).jsonValue as? [String: Any] {
                        if let color = configJson["color"] as? String {
                            self.newUIColor = color
                        }
                    }
                }
            } else {
                print("Error fetching remote config)")
                self.baseURL = "Loading..."
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

