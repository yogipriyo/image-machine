//
//  MachineListViewController.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

import UIKit

class MachineListViewController: UIViewController {
    
    private var viewModel: MachineListViewModels = MachineListViewModels()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getAllMachines()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.delegate = self
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

extension MachineListViewController: MachineListViewModelsDelegate {
    
    func populateMachineList(_ data: [Machine]) {
        DispatchQueue.main.async { [weak self] in
            print(data)
        }
    }
}
