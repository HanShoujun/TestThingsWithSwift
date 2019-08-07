//
//  TestOneViewController.swift
//  TestNavBar
//
//  Created by zero on 2019/8/2.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

class TestOneViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "TestOne"

//        self.scnav.tintColor = .purple
        self.scnav.bgAlpha = 0
        self.scnav.statusBarStyle = .lightContent
//        self.scnav.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow]
//        self.scnav.hidden = true

    }

    // MARK:
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return scnav.statusBarStyle
    }

}

extension TestOneViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}
