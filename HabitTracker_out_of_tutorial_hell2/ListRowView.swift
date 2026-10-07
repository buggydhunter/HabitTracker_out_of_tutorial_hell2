//
//  ListRowView.swift
//  HabitTracker_out_of_tutorial_hell2
//
//  Created by Onur Ay on 04.08.26.
//

import SwiftUI


struct ListRowView: View {
    
    @EnvironmentObject var allActivities: AllActivities
    let selectedDate: Date
    var activity : Activity
//    @State var activity: Activity
    
    var body: some View {

        HStack {
            
            Text(activity.habbitName)
                .bold()
                .foregroundStyle(activity.completed ? Color.black : Color.gray)
                .font(.title3)
            
            Spacer()
            
            Button {
                
                withAnimation {
                    
                    
                    
                    allActivities.hardenListForDate(for: selectedDate)
                    allActivities.toggleCompletion(for: activity, on: selectedDate)
    
                    
                }
                
           
                
                
            } label: {
                
                Image(systemName: activity.completed ? "checkmark.circle.fill" : "checkmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .foregroundStyle(activity.completed ? Color.black : Color.gray)
            }
            
        
            
            
        }
        .frame(minWidth: 200, minHeight: 75)
        .padding(.horizontal, 32)
        .background(activity.completed ? Color.green : Color.white)
        .cornerRadius(16)
        .overlay(
            
            RoundedRectangle(cornerRadius: 16)
                .stroke(activity.completed ? .green : .black, lineWidth: 4)
            
        )
        .padding(.horizontal, 8)

    }
}








#Preview {
    
}
