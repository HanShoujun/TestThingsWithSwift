//
//  RxSwiftViewController.swift
//  TestRxSwift-101
//
//  Created by hsj on 2019/6/23.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let viewModel = MusicViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.dataStream
            .bind(to: tableView.rx.items(cellIdentifier: "musicCell")){(_, music, cell) in
                cell.textLabel?.text = music.name
                cell.detailTextLabel?.text = music.singer
            }.disposed(by: disposeBag)

        tableView.rx.modelSelected(Music.self).subscribe(onNext: { (music) in
            print(music)
        }).disposed(by: disposeBag)
        
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
