//
//  AddHabitView.swift
//  HabitTracker_out_of_tutorial_hell2
//
//  Created by Onur Ay on 18.08.26.
//

import SwiftUI


struct AddHabitView : View {
    @EnvironmentObject var navPath : PathStore
    @EnvironmentObject var allActivities: AllActivities
    @State private var habitName : String = ""
    @State private var describedHbit : String = ""
    var date : Date
    
    var body: some View {
        
        
        VStack {
            TextField("Enter a habit name ", text: $habitName)
                .padding(.horizontal, 40,)
                .padding(.vertical, 40)
                .font(.title)
            
            TextField("You can add a description for your habit here", text: $describedHbit) .padding(.horizontal, 40)
                .font(.title2)
                .frame(height: 200)
                .border(.black)
                .background(Color.gray)
            
            Spacer()
            
            Button {
                
                let activity = Activity(id: UUID(), habbitName: habitName, completionCount: 0, benefits: [], completed: false, date: date)
                
                let currentList = allActivities.activitiesDict[date] ?? nil
                if currentList == nil {
                    allActivities.hardenListForDate(for: date)
                }
                
                allActivities.addToDictionary(key: date, activity: activity)
                allActivities.defaultActivityList.dailyActivities.append(activity)
                
                
                
                // NavigationPath back to root

                navPath.path = NavigationPath()
                
                
            } label: {
                Text("Add Habit")
                    .font(.title2)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 250, height: 80)
            .background(Color.blue)
            .padding(.vertical, 90)
            .clipShape(Circle())
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
}








// TODO: I need to add navigation path to the app -> need to rewatch pauls videos




#Preview {
    AddHabitView(date: Date())
        .environmentObject(AllActivities())
}
