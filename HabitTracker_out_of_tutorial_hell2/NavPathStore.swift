//
//  NavPathStore.swift
//  HabitTracker_out_of_tutorial_hell2
//
//  Created by Onur Ay on 19.08.26.
//

import SwiftUI
import Combine


class PathStore: ObservableObject {
    
    
    @Published var path : NavigationPath {
        
        didSet {
            
            save()
        }
    }
        private let savePath = URL.documentsDirectory.appending(path:"SavedPath")
        
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        
        path = NavigationPath()
    }
    
    
    func save() {
        guard let representation = path.codable else { return }
        
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
    
    
}
