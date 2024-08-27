import Foundation

extension HomeView {
    final class ViewModel: ObservableObject {
        @Published var isActive = false //timer used or not
        @Published var showingAlert = false
        @Published var time: String = "30:00"
        @Published var minutes: Float = 30.0 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        
        private var initialTime: Float = 30.0
        private var endDate = Date()
        
        func start(minutes: Float){
            self.initialTime = minutes
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: Date())!
            self.isActive = true
        }
        
        func reset() {
            self.isActive = false
            self.minutes = initialTime
            self.time = "\(Int(initialTime)):00"
        }
        
        func upDateCountdown() {
            guard isActive else { return }
            
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if diff <= 0 {
                self.isActive = false
                self.time = "00:00"
                self.showingAlert = true
                return
            }
            
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            
            self.time = String(format: "%d:%02d", minutes, seconds)
        }
    }
}
