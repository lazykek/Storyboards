//
//  ViewController.swift
//  Stroyboards
//
//  Created by Ilya Cherkasov on 19.08.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var testLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.testLabel.text = "Test"
    }


}

