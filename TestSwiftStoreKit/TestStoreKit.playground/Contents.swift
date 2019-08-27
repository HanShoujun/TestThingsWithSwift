import UIKit

struct PurchaseData: Codable, Hashable {
    var transactionid: String
    var productId: String
    var receiptData: Data?

    func hash(into hasher: inout Hasher) {
        hasher.combine(transactionid)
    }

    static func == (lhs: PurchaseData, rhs: PurchaseData) -> Bool {
        return lhs.transactionid == rhs.transactionid
    }
}

let data1 = PurchaseData(transactionid: "123", productId: "123123", receiptData: nil)
let data2 = PurchaseData(transactionid: "456", productId: "123123", receiptData: nil)
let data3 = PurchaseData(transactionid: "456", productId: "abcd", receiptData: nil)

var set = Set<PurchaseData>()

set.insert(data1)

set.insert(data2)

print(set)

set.remove(data3)
set.insert(data3)

print(set)
print(data3 == data2)

