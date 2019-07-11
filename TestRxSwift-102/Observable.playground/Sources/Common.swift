import Foundation

public func test(_ name: String, _ block: () -> Void) {
    print("\r\n*****Test: \(name)*******")
    block()
    print("*************************")
}

public func delay(_ delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}
