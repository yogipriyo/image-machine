//
//  MachineListViewController.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

import UIKit

class MachineListViewController: UIViewController {
    
    @IBOutlet weak var sortByNameButton: UIButton!
    @IBOutlet weak var sortByTypeButton: UIButton!
    @IBOutlet weak var addMachineButton: UIButton!
    @IBOutlet weak var machineListTableView: UITableView!
    
    private var viewModel: MachineListViewModels = MachineListViewModels()
    private var machineList: [Machine] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getAllMachines(sortingKey: SortingKeys.name.rawValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setupViews()
        
        setupTable()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    private func setupViews() {
        addMachineButton.tintColor = .white
        addMachineButton.layer.cornerRadius = 4
        
        sortByNameButton.tintColor = .white
        sortByNameButton.layer.cornerRadius = 4
        
        sortByTypeButton.tintColor = .white
        sortByTypeButton.layer.cornerRadius = 4
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
    
    @IBAction func sortByNameTapped(_ sender: UIButton) {
        viewModel.getAllMachines(sortingKey: SortingKeys.name.rawValue)
    }
    
    @IBAction func sortByTypeTapped(_ sender: UIButton) {
        viewModel.getAllMachines(sortingKey: SortingKeys.type.rawValue)
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
