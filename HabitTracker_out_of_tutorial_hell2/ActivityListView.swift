//
//  ActivityListView.swift
//  HabitTracker_out_of_tutorial_hell2
//
//  Created by Onur Ay on 04.08.26.
//

import SwiftUI



struct ActivityListView : View {
    
    let selectedDate: Date
    let activities : [Activity] // I made this one constant too!!
//    let selectedDate : Date

    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                    
                    ForEach(activities) { activity in
                        
                        ListRowView(selectedDate: selectedDate, activity: activity)
                        
                    }
            }
        }


    }
}



