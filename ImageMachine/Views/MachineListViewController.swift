//
//  MachineListViewController.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

import UIKit

class MachineListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    @IBAction func addMachineButtonTapped(_ sender: UIButton) {
        let addMachineVC = AddMachineViewController()
        self.navigationController?.pushViewController(addMachineVC, animated: true)
    }
    
}
