//
//  MachineListViewModels.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

import Foundation

protocol MachineListViewModelsDelegate {
    func populateMachineList(_ data: [Machine])
}

class MachineListViewModels {
    var delegate: MachineListViewModelsDelegate?
    private lazy var machineProvider: MachineProvider = { return MachineProvider() }()
    
    func getAllMachines() {
        machineProvider.getAllMachines() { [weak self] machineList in
            self?.delegate?.populateMachineList(machineList)
        }
    }
}
