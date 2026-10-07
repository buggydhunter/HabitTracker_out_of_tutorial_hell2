//
//  ContentView.swift
//  HabitTracker_out_of_tutorial_hell2
//
//  Created by Onur Ay on 03.08.26.
//

import SwiftUI

enum AppRoute: Hashable, Codable {
    case addHabit(Date) // > need to add date because it must be stored in userdefaults with the navpath
}

struct ContentView: View {
    @State private var showAddView : Bool = false
    private let dates: [Date]
    @State private var  selectedDate : Date
    @EnvironmentObject var allActivities : AllActivities
    @EnvironmentObject var pathStore : PathStore

    
    init() {
            // Step A: Generate the data from your clean model
            let dataModel = HorizontalDateData()
            
            // Step B: Assign the dates array
            self.dates = dataModel.dates
            
            // Step C: Safely initialize the State wrapper using the array we just created!
            self._selectedDate = State(initialValue: dataModel.dates[365])
        }

    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            VStack {
                
                DateScrollView(selectedDate: $selectedDate, dates: dates)
                    .padding(.vertical)
                
                if allActivities.presentInDictionary(for: selectedDate, dictionary: allActivities.activitiesDict) {
                    
                    ActivityListView(selectedDate: selectedDate, activities: allActivities.activitiesDict[selectedDate]!.dailyActivities)
                    
                } else {
                    
                    ActivityListView(selectedDate: selectedDate, activities: allActivities.defaultActivityList.dailyActivities)
                    
                }
                
                HStack{
                    Spacer()
                    
                    NavigationLink(value: AppRoute.addHabit(selectedDate)) {
                        Label("Add Habit",systemImage: "plus.circle.fill")
                            .font(.title2)
                    }
                    .padding(.horizontal, 30)
                    
                    
               
                }
                
                
                
            }
            .navigationTitle("Habitracker out of THell")
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .addHabit(let passedDate):
                    AddHabitView(date: passedDate)
                }
            }
        }
    }
}














#Preview {
    ContentView()
        .environmentObject(AllActivities())
}
