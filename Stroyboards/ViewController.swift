//
//  ViewController.swift
//  Stroyboards
//
//  Created by Ilya Cherkasov on 19.08.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var anotherTestLabel: UILabel!
    @IBOutlet private var testLabel: UILabel!
    @objc private var text: String!

    required init?(coder: NSCoder) {
        /*
         storyboard.instantiateViewController -> парсинг -> init(coder: NSCoder)
         имя переменной (testLabel) связывается с ObjectID
         Делаем вывод, что connection - это тоже элемент со своим уникальным ID
         Также есть возможность сменить ID элемента
         https://stackoverflow.com/questions/38716293/main-storyboardc-could-not-be-opened-interface-builder-cannot-open-compiled-nib
         */
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.testLabel.text = "Test"
        print(self.text)
    }
}

