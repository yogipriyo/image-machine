//
//  ScannerViewModels.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 23/12/22.
//

protocol ScannerViewModelsDelegate {
    func searchFinished(_ machineData: Machine)
}

class ScannerViewModels {
    var delegate: ScannerViewModelsDelegate?
    private lazy var machineProvider: MachineProvider = { return MachineProvider() }()
    
    func getMachine(_ codeNumber: Int) {
        machineProvider.getMachine(codeNumber) { [weak self] machineData in
            self?.delegate?.searchFinished(machineData)
        }
    }
}
