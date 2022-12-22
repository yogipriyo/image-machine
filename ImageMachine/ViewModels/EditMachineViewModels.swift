//
//  EditMachineViewModels.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 23/12/22.
//

protocol EditMachineViewModelsDelegate {
    func updateMachineFinished()
}


class EditMachineViewModels {
    var delegate: EditMachineViewModelsDelegate?
    private lazy var machineProvider: MachineProvider = { return MachineProvider() }()
    
    func updateMachine(_ machineData: Machine) {
        machineProvider.updateMachine(machineData) { [weak self] in
            self?.delegate?.updateMachineFinished()
        }
    }
}
