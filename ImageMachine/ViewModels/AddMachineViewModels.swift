//
//  AddMachineViewModels.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

protocol AddMachineViewModelsDelegate {
    func saveMachineFinished()
}


class AddMachineViewModels {
    var delegate: AddMachineViewModelsDelegate?
    private lazy var machineProvider: MachineProvider = { return MachineProvider() }()
    
    func saveMachine(_ machineData: Machine) {
        machineProvider.addMachine(machineData) { [weak self] in
            self?.delegate?.saveMachineFinished()
        }
    }
}
