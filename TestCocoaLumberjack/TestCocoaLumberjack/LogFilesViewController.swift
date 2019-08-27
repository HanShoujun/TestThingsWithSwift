//
//  LogFilesViewController.swift
//  TestCocoaLumberjack
//
//  Created by zero on 2019/8/14.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

class LogFilesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let logs = LoggerManager.shared.logPaths
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        LoggerManager.shared.fileLogger.logFileManager.logFilesDiskQuota
    }

}

extension LogFilesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let info = logs[indexPath.row]

        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "LogDetailViewController") as! LogDetailViewController
        vc.info = info

        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LogFilesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = logs[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }

}
