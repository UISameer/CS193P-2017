import Foundation

extension Int {
    
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32.init(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32.init(abs(self))))
        } else {
            return 0
        }
    }
}
