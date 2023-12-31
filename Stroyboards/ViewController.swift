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
        coder.swizzle()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.testLabel.text = "Test"
        print(self.text)
    }

    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
}

class CustomLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension NSCoder {
    func swizzle() {
        let aClass: AnyClass! = object_getClass(self)
        let originalMethod = class_getInstanceMethod(aClass, #selector(decodeObject(forKey:)))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(decodeObjectSwizzled(forKey:)))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }

    @objc func decodeObjectSwizzled(forKey key: String) -> Any? {
        let object = self.decodeObjectSwizzled(forKey: key)
        DispatchQueue.main.async {
            print(
                "KEY: " + key + "\n"
                + "VALUE: " + object.debugDescription + "\n"
                + "-----"
            )
        }
        return object
    }
}
