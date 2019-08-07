import Foundation
import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let publishSubject = PublishSubject<Int>()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let button = UIButton(type: .system)
        button.setTitle("Click", for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        button.addTarget(self, action:#selector(ViewController.click), for: .touchUpInside)
        view.addSubview(button)

        publishSubject
            .asObserver()
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe({ (event) in
                print(event)
            })
            .disposed(by: disposeBag)
    }

    @objc func click() {
        publishSubject.onNext(123)
    }

}
