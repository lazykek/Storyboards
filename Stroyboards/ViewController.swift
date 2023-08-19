//
//  ViewController.swift
//  Stroyboards
//
//  Created by Ilya Cherkasov on 19.08.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var wrongTestLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.wrongTestLabel.text = "Test"
    }


}

