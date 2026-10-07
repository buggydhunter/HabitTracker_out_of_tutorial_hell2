import SwiftUI



struct DateCell: View {
    let date: Date
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Text(date, format: .dateTime.weekday(.short))
            Text(date, format: .dateTime.day())
                .bold()
            Text(date, format: .dateTime.month())
                .bold()
        }
        .frame(width: 75, height: 75)
        .background(isSelected ? Color.red : Color.gray.opacity(0.3))
        .clipShape(Circle())
    }
}
