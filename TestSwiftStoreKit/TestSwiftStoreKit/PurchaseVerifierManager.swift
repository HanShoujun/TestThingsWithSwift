//
//  VerifierManager.swift
//  TestSwiftStoreKit
//
//  Created by zero on 2019/8/9.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit
import KeychainAccess
import StoreKit
import SwiftyStoreKit

struct Config {
    static let KService = "com.biblo.ireaderbook"
    static let KReceipts = "com.biblo.receipts"
}

class PurchaseVerifierManager {
    static let shared = PurchaseVerifierManager()

    let keychain = Keychain(service: Config.KService)

    func config() {
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { (_) in
            self.verifyPurchaseList()
        }
        NotificationCenter.default.addObserver(forName: UIApplication.didFinishLaunchingNotification, object: nil, queue: nil) { (_) in
            self.verifyPurchaseList()
        }
    }
}

extension PurchaseVerifierManager {

    func newPurchased(_ transaction: SKPaymentTransaction, completion: ((VerifyResult) -> Void)?) {
        guard let tranid = transaction.transactionIdentifier else { return }

        SwiftyStoreKit.fetchReceipt(forceRefresh: false, completion: { (result) in
            switch result {
            case .success(let receiptData):
                let data = PurchaseData(
                    transactionid: tranid,
                    productId: transaction.payment.productIdentifier,
                    receiptData: receiptData,
                    date: transaction.transactionDate ?? Date())
                self.savePurchaseData(data)
                self.verifyWithServer(data, completion: completion)
            case .error(let error):
                print("fetchReceiptError:\(error)")
                completion?(.notPurchased)
            }
        })
    }

    func verifyPurchaseList() {
        print("verifyPurchaseList")
        let list = getPurchaseList()

        list.forEach { (data) in
            self.verifyWithServer(data, completion: nil)
        }
    }

    func verifyWithServer(_ purchase: PurchaseData, completion: ((VerifyResult) -> Void)?) {
        print("verifyWithServer: " + purchase.description())

        let appleValidator = AppleReceiptValidator(service: .sandbox, sharedSecret: "3326d6b502ac445ca60539d59aea2322")
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { (result) in
            switch result {
            case .success(let receipt):
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: purchase.productId,
                    inReceipt: receipt)
                switch purchaseResult {
                case .purchased:
                    print("purchase Successful: \(purchase.description())")
                    completion?(.purchased)
                    self.removePurchase(purchase)
                case .notPurchased:
                    print("notPurchased：\(purchase.description())")
                    completion?(.notPurchased)
                }
            case .error(let error):
                print(error)
                completion?(.notPurchased)
            }
        }
    }

}

// MARK: - 存储相关
extension PurchaseVerifierManager {

    /// 保存支付记录
    func savePurchaseData(_ data: PurchaseData) {
        var purchaseList = getPurchaseList()
        /// 添加失败，则中断
        guard purchaseList.insert(data).inserted else { return }

        do {
            let jsonData = try JSONEncoder().encode(purchaseList)
            try keychain.set(jsonData, key: Config.KReceipts)
        } catch {
            print(error)
        }
    }

    /// 获取支付记录
    func getPurchaseList() -> Set<PurchaseData> {
        guard let list = keychain[data: Config.KReceipts] else { return [] }
        do {
            let purchaseList = try JSONDecoder().decode(Set<PurchaseData>.self, from: list)
            return purchaseList
        } catch {
            print(error)
            return []
        }
    }

    /// 删除支付记录
    func removePurchase(_ purchase: PurchaseData) {
        var purchaseList = getPurchaseList()
        purchaseList.remove(purchase)

        do {
            let jsonData = try JSONEncoder().encode(purchaseList)
            try keychain.set(jsonData, key: Config.KReceipts)
        } catch {
            print(error)
        }
    }

    /// 更新支付记录
    func updatePurchase(_ data: PurchaseData) {
        var purchaseList = getPurchaseList()
        purchaseList.remove(data)
        purchaseList.insert(data)

        do {
            let jsonData = try JSONEncoder().encode(purchaseList)
            try keychain.set(jsonData, key: Config.KReceipts)
        } catch {
            print(error)
        }
    }
}

struct PurchaseData: Codable, Hashable {
    var transactionid: String
    var productId: String
    var receiptData: Data
    var retryTime: Int
    var date: Date

    init(transactionid: String,
         productId: String,
         receiptData: Data,
         retryTime: Int = 0,
         date: Date) {
        self.transactionid = transactionid
        self.productId = productId
        self.receiptData = receiptData
        self.retryTime = retryTime
        self.date = date
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(transactionid)
    }

    static func == (lhs: PurchaseData, rhs: PurchaseData) -> Bool {
        return lhs.transactionid == rhs.transactionid
    }

    func description() -> String {
        return "{ transactionid: \(transactionid)  ^^^ productId: \(productId)  ^^^ receiptData: \(receiptData.hashValue)}"
    }
}

public enum VerifyResult {
    case purchased
    case notPurchased
}
