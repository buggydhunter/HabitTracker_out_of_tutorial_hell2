//
//  HabitTracker_out_of_tutorial_hell2App.swift
//  HabitTracker_out_of_tutorial_hell2
//
//  Created by Onur Ay on 03.08.26.
//

import SwiftUI

@main
struct HabitTracker_out_of_tutorial_hell2App: App {
    
    @StateObject var allActivities: AllActivities = AllActivities()
    @StateObject var navPath : PathStore = PathStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(allActivities)
                .environmentObject(navPath)
        }
    }
}
