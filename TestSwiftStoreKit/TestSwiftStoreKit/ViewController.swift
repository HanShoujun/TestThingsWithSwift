//
//  ViewController.swift
//  TestSwiftStoreKit
//
//  Created by zero on 2019/8/9.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit
import PKHUD

class ViewController: UIViewController {

    var items = ["com.biblo.ireaderbook.bean.2100",
                 "com.biblo.ireaderbook.bean.4200"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        purchase(items[indexPath.row])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

// MARK: - 支付请求
extension ViewController {
    func purchase(_ productId: String) {

        HUD.show(.progress)
        SwiftyStoreKit.purchaseProduct(productId) { (result) in
            switch result {
            case .success(let purchaseDetails):
                print("purchaseDetails:\(purchaseDetails.productId) + \(purchaseDetails.transaction.transactionIdentifier ?? "") + \(purchaseDetails.transaction.transactionDate?.description ?? ""))")

                PurchaseVerifierManager.shared.newPurchased(purchaseDetails.transaction as! SKPaymentTransaction, completion: { result in
                    switch result {
                    case .purchased:
                        HUD.flash(.label("充值成功"), delay: 1)
                    case .notPurchased:
                        HUD.hide()
                    }
                })
            case .error(let error):
                print(error.descCode())
                switch error.code {
                case .paymentCancelled:
                    HUD.flash(.label("用户取消"), delay: 1)
                default:
                    HUD.hide()
                }
            }
        }

    }
}

