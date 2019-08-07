//: [Previous](@previous)

import Foundation


struct TestVar {
    var test: String {
        get {
            return "23"
        }
        set {

        }
    }
}

protocol TestProtocol {
    var testVar: TestVar { get set }
}

extension TestProtocol {
    var testVar: TestVar{
        get {
            return TestVar()
        }
        set {

        }
    }
}

extension BaseClass: TestProtocol {
    /// 如果把下面的代码注释了，会编译错误。
    var testVar: TestVar{
        get {
            return TestVar()
        }
        set {

        }
    }
}

class BaseClass {

    func test() {
        /// 如果上面代码注释了，此处报错。
        /// 在 TestProtocol 的 extension 中声明的setter方法不能调用，必须在 BaseClass 中声明setter
        self.testVar = TestVar()
    }
}

print("build successful")
