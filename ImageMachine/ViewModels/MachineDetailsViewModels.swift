//
//  MachineDetailsViewModels.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 21/12/22.
//

protocol MachineDetailsViewModelsDelegate {
    func machineDeleted()
}

class MachineDetailsViewModels {
    var delegate: MachineDetailsViewModelsDelegate?
    private lazy var machineProvider: MachineProvider = { return MachineProvider() }()
    
    func deleteMachine(_ machineId: Int) {
        machineProvider.deleteMachine(machineId) { [weak self] in
            self?.delegate?.machineDeleted()
        }
    }
}
