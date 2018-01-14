//
//  ViewController.swift
//  SegmentedControl
//
//  Created by FAP on 14/01/2018.
//  Copyright © 2018 Filipe Souza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func customSegmentValueChanged(_ sender: CustomSegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Index : \(sender.selectedSegmentIndex)")
        case 1:
            print("Index : \(sender.selectedSegmentIndex)")
        case 2:
            print("Index : \(sender.selectedSegmentIndex)")
        default:
            print("Index not found")
        }
    }
    

}

