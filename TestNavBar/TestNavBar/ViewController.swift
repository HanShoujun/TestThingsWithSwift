//
//  ViewController.swift
//  TestNavBar
//
//  Created by zero on 2019/8/1.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Main"

        self.scnav.tintColor = .white
        self.scnav.bgAlpha = 1
        self.scnav.statusBarStyle = .lightContent
        self.scnav.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        if #available(iOS 11.0, *) {
            self.collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setNeedsStatusBarAppearanceUpdate()
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ViewController: UIScrollViewDelegate {
    //MARK:UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let contentOffsetY = scrollView.contentOffset.y
        let showNavBarOffsetY = 200 - topLayoutGuide.length

        //navigationBar alpha
        var navAlpha = (contentOffsetY - showNavBarOffsetY) / 100.0
        if navAlpha > 1 {
            navAlpha = 1
        }
        if navAlpha < 0 {
            navAlpha = 0
        }
        scnav.bgAlpha = navAlpha
        if navAlpha > 0.8 {
            scnav.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
            scnav.tintColor = UIColor.blue
            scnav.statusBarStyle = .default
        }else{
            scnav.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            scnav.tintColor = UIColor.white
            scnav.statusBarStyle = .lightContent
        }
    }
}
