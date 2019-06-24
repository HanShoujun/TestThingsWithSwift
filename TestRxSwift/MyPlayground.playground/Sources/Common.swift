import Foundation

public func example(_ description: String, block: () -> Void) {
    print("-------Example : ", description, "---------")
    block()
}
