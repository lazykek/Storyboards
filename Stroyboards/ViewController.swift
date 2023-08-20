//
//  ViewController.swift
//  Stroyboards
//
//  Created by Ilya Cherkasov on 19.08.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var anotherTestLabel: CustomLabel!
    @IBOutlet private var testLabel: UILabel!
    @objc private var text: String!

    required init?(coder: NSCoder) {
        /*
         storyboard.instantiateViewController -> парсинг -> init(coder: NSCoder)
         имя переменной (testLabel) связывается с ObjectID
         Делаем вывод, что connection - это тоже элемент со своим уникальным ID
         Также есть возможность сменить ID элемента
         https://stackoverflow.com/questions/38716293/main-storyboardc-could-not-be-opened-interface-builder-cannot-open-compiled-nib
         Воспроизводим ошибку
         Thread 1: "Could not load NIB in bundle: 'NSBundle </Users/ilya/Library/Developer/CoreSimulator/Devices/008593C9-D813-48AF-834B-30468243C9DE/data/Containers/Bundle/Application/E9FE48D3-7C7E-46B8-BF3A-FA9DB22AA382/Stroyboards.app> (loaded)' with name 'ViewControllerID' and directory 'Main.storyboardc'", переименовывая в ипашке файл
         */
        let array = coder.value(forKeyPath: "arrayClass")
        let table = coder.value(forKeyPath: "keyIDTable") as! NSObject
        let dictionary = coder.value(forKeyPath: "dictionaryClass") as! NSObject
        let context = coder.value(forKeyPath: "_storyboardDecodingContext") as! NSObject
        print(coder.reflected())
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.testLabel.text = "Test"
        print(self.text)
    }
}

class CustomLabel: UILabel {
    required init?(coder: NSCoder) {
        let table = coder.value(forKeyPath: "keyIDTable") as! NSObject
        print(coder.reflected())
        super.init(coder: coder)
    }
}

protocol Reflectable: AnyObject {
    func reflected() -> [String: Any?]
}

extension Reflectable {

    func reflected() -> [String: Any?] {
        let mirror = Mirror(reflecting: self)
        var dict: [String: Any?] = [:]
        for child in mirror.children {
            guard let key = child.label else {
                continue
            }
            dict[key] = child.value
        }
        return dict
    }

    var reflectedString: String {
        let reflection = reflected()
        var result = String(describing: self)
        result += " { \n"
        for (key, val) in reflection {
            result += "\t\(key): \(val ?? "null")\n"
        }
        return result + "}"
    }

}

extension Reflectable where Self: NSObject {

    func reflected() -> [String : Any?] {

        var count: UInt32 = 0

        guard let properties = class_copyPropertyList(Self.self, &count) else {
            return [:]
        }

        var dict: [String: Any] = [:]
        for i in 0..<Int(count) {
            let name = property_getName(properties[i])
            guard let nsKey = NSString(utf8String: name) else {
                continue
            }
            let key = nsKey as String
            guard responds(to: Selector(key)) else {
                continue
            }
            dict[key] = value(forKey: key)
        }
        free(properties)

        return dict
    }

}

extension NSObject: Reflectable {}
