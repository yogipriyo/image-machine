//
//  MachineListViewModels.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

protocol MachineListViewModelsDelegate {
    func populateMachineList(_ data: [Machine])
}

class MachineListViewModels {
    var delegate: MachineListViewModelsDelegate?
    private lazy var machineProvider: MachineProvider = { return MachineProvider() }()
    
    func getAllMachines(sortingKey: String) {
        machineProvider.getAllMachines(sortingKey: sortingKey) { [weak self] machineList in
            self?.delegate?.populateMachineList(machineList)
        }
    }
}
