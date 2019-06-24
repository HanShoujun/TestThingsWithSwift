//
//  TranditionalViewController.swift
//  TestRxSwift-101
//
//  Created by hsj on 2019/6/23.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

class TranditionalViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let viewModel = MusicViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    

}

extension TranditionalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell")!
        let model = viewModel.data[indexPath.row]
        cell.textLabel?.text = model.name
        cell.detailTextLabel?.text = model.singer
        return cell
    }


}

extension TranditionalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = viewModel.data[indexPath.row]
        print(model)
    }
}
