//
//  CollectViewViewController.swift
//  TestRxSwift-102
//
//  Created by zero on 2019/7/9.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import MagazineLayout

class CollectViewViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //定义布局方式以及单元格大小
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 70)

        //创建集合视图
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.setCollectionViewLayout(flowLayout, animated: false)

        //创建一个重用的单元格
        self.collectionView.register(MyCollectionViewCell.self,
                                     forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(self.collectionView!)

        //初始化数据

        let items = Observable.just([
            SectionModel(model: "语言", items:[
                    "Java",
                    "Swift"
                ])
            ])

        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>(
            configureCell: { (ds, cv, ip, element) -> UICollectionViewCell in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                              for: ip) as! MyCollectionViewCell
                cell.label.text = "\(ip.item)：\(element)"
                return cell
            }
        )

        //设置单元格数据（其实就是对 cellForItemAt 的封装）
        items
            .bind(to: collectionView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)

        //获取选中项的索引
        collectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("选中项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)


        //获取选中项的内容
        collectionView.rx.modelSelected(String.self).subscribe(onNext: { item in
            print("选中项的标题为：\(item)")
        }).disposed(by: disposeBag)

    }

    func showMessage(_ message: String) {
        print(message)
    }

}
