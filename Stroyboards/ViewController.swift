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
         зачем нужен  id="oSe-0O-rdk" - ?
         */
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.testLabel.text = "Test"
        print(self.text)
    }
}

