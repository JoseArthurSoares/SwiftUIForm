//
//  SwiftUIFormApp.swift
//  SwiftUIForm
//
//  Created by Arthur Soares on 03/03/2023.
//

import SwiftUI

@main
struct SwiftUIFormApp: App {
    var settingStore = SettingStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView(settingStore: settingStore)
        }
    }
}
