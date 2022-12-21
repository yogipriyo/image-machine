//
//  MachineDetailsViewController.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 21/12/22.
//

import UIKit
import PhotosUI

class MachineDetailsViewController: UIViewController {
    
    @IBOutlet weak var machineIdLabel: UILabel!
    @IBOutlet weak var machineNameLabel: UILabel!
    @IBOutlet weak var machineTypeLabel: UILabel!
    @IBOutlet weak var machineCodeNumberLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    private var machineDetails: Machine
    private var viewModel: MachineDetailsViewModels = MachineDetailsViewModels()
    
    init(_ machineDetails: Machine) {
        self.machineDetails = machineDetails
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Machine Details"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegation()
        populateContent()
    }
    
    private func setupDelegation() {
        viewModel.delegate = self
    }
    
    private func populateContent() {
        machineIdLabel.text = String(machineDetails.id)
        machineNameLabel.text = machineDetails.name
        machineTypeLabel.text = machineDetails.type
        machineCodeNumberLabel.text = String(machineDetails.codeNumber)
    }
    
    @IBAction func machineImageTapped(_ sender: UIButton) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 3 // Selection limit. Set to 0 for unlimited.
        configuration.filter = .images // he types of media that can be get.
        // configuration.filter = .any([.videos,livePhotos]) // Multiple types of media
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Warning!", message: "Are you sure want to remove order details?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) { [weak self] UIAlertAction in
            self?.viewModel.deleteMachine(self?.machineDetails.id ?? 0)
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel) { UIAlertAction in
            print("Cancel Pressed")
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
    
}

extension MachineDetailsViewController: MachineDetailsViewModelsDelegate {
    func machineDeleted() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Success!", message: "Machine has been deleted", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default) { [weak self] UIAlertAction in
                self?.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(okAction)

            self?.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension MachineDetailsViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        let itemProviders = results.map(\.itemProvider)
        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            print(image)
                        }
                    }
                }
            }
        }
    }
    
    
}
