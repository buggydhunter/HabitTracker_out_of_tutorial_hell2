//
//  DataModel.swift
//  HabitTracker_out_of_tutorial_hell2
//
//  Created by Onur Ay on 03.08.26.
//

import Foundation
import Combine
import SwiftUI

//This class should handle how the data should behave in my app
//OK the data model is up for now, i need to check the suggestions by gemini and update it a bit more but then i can work on the ui 
struct Activity : Identifiable, Hashable, Codable {
    var id : UUID // do i even need this
    var habbitName : String
    var completionCount : Int
    var benefits : [String]
    var description : String?
    var completed : Bool
    let date : Date
    
}


struct DailyActivityList : Hashable, Codable {
    var id: Date
    var dailyActivities : [Activity]
}

class AllActivities : ObservableObject  {
   // Missing guard let etc. to see if we can first load the array or not but first i just wanna make this app work
    @Published var activitiesDict :  [Date : DailyActivityList] {
        
        didSet {
            
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path:"SavedActivities")
        
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Date: DailyActivityList].self, from: data) {
                activitiesDict = decoded
                return
            }
        }
        
        activitiesDict = [:]
    }
    
    
    func save() {

        do {
            let data = try JSONEncoder().encode(activitiesDict)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
    
    
    var defaultActivityList: DailyActivityList = DailyActivityList(id: Date(), dailyActivities:
    
    [
        Activity(id: UUID(), habbitName: "Walking", completionCount: 0, benefits: ["Cardiovascular Health, Stress Management"], completed: false, date: Date()),
        Activity(id: UUID(), habbitName: "Sleeping 8 hours", completionCount: 0, benefits: ["Cardiovascular Health, Stress Management"], completed: false, date: Date()),
        Activity(id: UUID(), habbitName: "Cycling", completionCount: 0, benefits: ["Cardiovascular Health, Stress Management"], completed: false, date: Date()),
        Activity(id: UUID(), habbitName: "Weight Lifting", completionCount: 0, benefits: ["Cardiovascular Health, Stress Management"], completed: false, date: Date()),
        Activity(id: UUID(), habbitName: "Eating Healthy", completionCount: 0, benefits: ["Cardiovascular Health, Stress Management"], completed: false, date: Date()),
        Activity(id: UUID(), habbitName: "Playing VideoGames", completionCount: 0, benefits: ["Cardiovascular Health, Stress Management"], completed: false, date: Date())
    ]
    
    )
        
    
    
    
    
    func presentInDictionary(for date: Date, dictionary: [Date: DailyActivityList]) -> Bool {
    
        let calendar = Calendar.current
        
        if dictionary[calendar.startOfDay(for: date)] != nil {
            return true
        }
        
        
        return false
    }
    
    
    func hardenListForDate(for date: Date) {
        
        let dateNormalization = Calendar.current.startOfDay(for: date)
        
        if presentInDictionary(for: date, dictionary: activitiesDict) {
            return
        }
        
        activitiesDict[dateNormalization] = defaultActivityList
    }
    
    func addToDictionary(key: Date, activity: Activity) {
        let dateNormalization = Calendar.current.startOfDay(for: key)

        activitiesDict[dateNormalization]?.dailyActivities.append(activity)
    }
    
    func removeFromDictionary(key: Date, activity: Activity) {
        let dateNormalization = Calendar.current.startOfDay(for: key)
        activitiesDict[dateNormalization]?.dailyActivities.removeAll(where: {$0.id == activity.id})

    }
    
    func toggleCompletion(for activity: Activity, on date: Date) {
        
        let normalizedDate = Calendar.current.startOfDay(for: date)
        
        if let index = activitiesDict[date]?.dailyActivities.firstIndex(where: {$0.id == activity.id})! {
         
            activitiesDict[normalizedDate]?.dailyActivities[index].completed.toggle()
            
        }
        
    }
    
    
    
    
    
    // How should i structure the list view now? For each array in allActivities I should create a list View -> I should pass a activities array to the list view
    // do not only pass the array but also the selected date from contentview to the List view -> should that be a navigation stack then???
    // for each different date/ index in allActivities I should create a list view
    
    // TODO's -> 1. create the list View
    
    /**
        First factor out the list view row item
     Once that is done, just create a list view which should be then an activity
     */
    
    
    
    
    
    //TODO's -> 2. create navigationpath for each list
    
    /**Navigate to the list view of the selected date
        Look at how to incorporate the allActivities stuff
     */
    
    
    
    
    //TODO's -> 3. create a detail view for each row in the list
    /**This should be easy in comparison*/
    
    
}


struct HorizontalDateData {
    
    let dates: [Date]
    
    init() {
            let dates: [Date] = {
            let calendar  = Calendar.current
                let today = calendar.startOfDay(for: Date())
                
            return (0...2000)
                .map {
                    calendar.date(byAdding: .day, value: $0 - 365, to: today)!
                }
        } ()
        
        self.dates = dates
        
    }
    
}
