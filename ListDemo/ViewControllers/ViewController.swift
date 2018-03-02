//
//  ViewController.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/1/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func customizeItemTapped(sender: UIButton) {
        guard let customizeItemVC = storyboard?.instantiateViewController(withIdentifier: "CustomizeItemNavViewController") else { return }
        present(customizeItemVC, animated: true, completion: nil)
    }
}

