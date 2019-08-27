//
//  Application.swift
//  TestSwiftStoreKit
//
//  Created by zero on 2019/8/9.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit

class Application {

    /// 配置
    static func config() {

        PurchaseVerifierManager.shared.config()

        /// 监听启动时支付更新
        SwiftyStoreKit.completeTransactions { (purchaseList) in
            /// 遍历支付订单
            for purchase in purchaseList {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    print("{transactionid:\(purchase.transaction.transactionIdentifier ?? "") + \(purchase.transaction.transactionDate?.description ?? "") }")

                    PurchaseVerifierManager.shared.newPurchased(purchase.transaction as! SKPaymentTransaction, completion: nil)
                case .failed:
                    if let transaction = purchase.transaction as? SKPaymentTransaction,  let skerror = transaction.error as? SKError {
                        print(skerror.descCode())
                    }
                case .purchasing, .deferred:
                    break
                @unknown default:
                    break
                }
            }
        }


    }

}


// MARK: - SKError
extension SKError {
    func descCode() -> String {
        var desc = ""
        switch code {
        case .paymentCancelled:
            desc = "paymentCancelled"
        case .clientInvalid:
            desc = "clientInvalid"
        case .storeProductNotAvailable:
            desc = "storeProductNotAvailable"
        case .paymentInvalid:
            desc = "paymentInvalid"
        case .paymentNotAllowed:
            desc = "paymentNotAllowed"
        default:
            desc = "code:\(code.rawValue)"
        }
        return "{SKError: \(desc)}"
    }
}
