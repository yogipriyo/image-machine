//
//  MachineDetailsViewModels.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 21/12/22.
//

import Foundation

protocol MachineDetailsViewModelsDelegate {
    func machineDeleted()
    func imageSaved()
    func retrievedImages(_ datas: [Data])
}

class MachineDetailsViewModels {
    var delegate: MachineDetailsViewModelsDelegate?
    private lazy var machineProvider: MachineProvider = { return MachineProvider() }()
    
    func deleteMachine(_ machineId: Int) {
        machineProvider.deleteMachine(machineId) { [weak self] in
            self?.delegate?.machineDeleted()
        }
    }
    
    func saveImage(selectedImage: Data, machineId: Int, imageId: Int) {
        machineProvider.addImage(imageData: selectedImage, machineId: machineId, imageId: imageId) { [weak self] in
            self?.delegate?.imageSaved()
        }
    }
    
    func getImages(machineId: Int) {
        machineProvider.getMachineImages(machineId) { [weak self] datas in
            self?.delegate?.retrievedImages(datas)
        }
    }
}
