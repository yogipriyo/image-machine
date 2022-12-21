//
//  MachineListViewController.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

import UIKit

class MachineListViewController: UIViewController {
    
    @IBOutlet weak var addMachineButton: UIButton!
    @IBOutlet weak var machineListTableView: UITableView!
    
    private var viewModel: MachineListViewModels = MachineListViewModels()
    private var machineList: [Machine] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getAllMachines()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.delegate = self
        addMachineButton.tintColor = .white
        
        setupTable()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    private func setupTable() {
        machineListTableView.delegate = self
        machineListTableView.dataSource = self
        machineListTableView.register(
            UINib(nibName: TableViewCellIdentifier.machineListCellId, bundle: nil),
            forCellReuseIdentifier: TableViewCellIdentifier.machineListCellId
        )
    }
    
    @IBAction func addMachineButtonTapped(_ sender: UIButton) {
        let addMachineVC = AddMachineViewController()
        self.navigationController?.pushViewController(addMachineVC, animated: true)
    }
    
}

extension MachineListViewController: MachineListViewModelsDelegate {
    
    func populateMachineList(_ data: [Machine]) {
        DispatchQueue.main.async { [weak self] in
            self?.machineList = data
            self?.machineListTableView.reloadData()
        }
    }
    
}

extension MachineListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        machineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCellIdentifier.machineListCellId, for: indexPath) as? MachineTableViewCell {
            cell.setupContent(machineList[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let machineDetailsVC: MachineDetailsViewController = MachineDetailsViewController(machineList[indexPath.row])
        navigationController?.pushViewController(machineDetailsVC, animated: true)
    }
    
}
