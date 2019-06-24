import Foundation

public func test(_ name: String, _ block: () -> Void) {
    print("*****Test: \(name)*******")
    block()
    print("*************************")
}
