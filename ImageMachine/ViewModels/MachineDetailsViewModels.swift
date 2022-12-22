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
    func retrievedImages(datas: [Data], ids: [Int])
    func imageDeleted()
}

class MachineDetailsViewModels {
    var delegate: MachineDetailsViewModelsDelegate?
    private lazy var machineProvider: MachineProvider = { return MachineProvider() }()
    
    func deleteMachine(_ machineId: Int) {
        machineProvider.deleteMachine(machineId) { [weak self] in
            self?.delegate?.machineDeleted()
        }
    }
    
    func deleteImage(_ imageId: Int) {
        machineProvider.deleteImage(imageId) { [weak self] in
            self?.delegate?.imageDeleted()
        }
    }
    
    func saveImage(selectedImage: Data, machineId: Int, imageId: Int) {
        machineProvider.addImage(imageData: selectedImage, machineId: machineId, imageId: imageId) { [weak self] in
            self?.delegate?.imageSaved()
        }
    }
    
    func getImages(machineId: Int) {
        machineProvider.getMachineImages(machineId) { [weak self] datas, ids  in
            self?.delegate?.retrievedImages(datas: datas, ids: ids)
        }
    }
}
