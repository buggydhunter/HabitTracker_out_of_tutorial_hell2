//
//  DateScrollViewCompleteView.swift
//  HabitTracker_out_of_tutorial_hell2
//
//  Created by Onur Ay on 05.08.26.
//

import SwiftUI


struct DateScrollView: View {
    
    @Binding var selectedDate : Date
    @State var dates  : [Date]

    
    var body : some View {
        
        
        GeometryReader { geometry in
            
            ScrollViewReader { scrollValue in
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHStack(spacing: 8) {
                        ForEach(dates, id: \.self) { date in
                            
                            DateCell(date: date, isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate))
                                .id(date)
                                .onTapGesture {
                                    withAnimation {
                                        selectedDate = date
                                    }
                                }
                            
                        }
                        .border(Color.blue)
                    }
                    .padding(.horizontal, geometry.size.width / 2)
                }
                .onChange(of: selectedDate, initial: true) { _,newValue in
                    withAnimation {
                        scrollValue.scrollTo(newValue, anchor: .center)
                    }
                    
                    
                    
                }
                
                
            }
            
            
        }
        .frame(height: 80)
        .border(Color.red)


    }
}



struct DateScrollViewPreviewWrapper: View {
    
    // 2. Give it actual @State so the data can change when you tap
    @State private var selectedDate: Date
    let dates: [Date]
    
    // 3. Set up our data just like we did in ContentView
    init() {
        let dataModel = HorizontalDateData()
        self.dates = dataModel.dates
        self._selectedDate = State(initialValue: dataModel.dates[365])
    }
    
    var body: some View {
        // 4. Call your actual view, passing the real binding!
        DateScrollView(selectedDate: $selectedDate, dates: dates)
    }
}



#Preview {
//    // 1. Set up your pure data first
//    let dataModel = HorizontalDateData()
//    let dates = dataModel.dates
//    
//    // 2. Return the view, using .constant to fake the binding
//    return DateScrollView(
//        selectedDate: .constant(dates[365]),
//        dates: dates
//    )
    
    DateScrollViewPreviewWrapper()
}
