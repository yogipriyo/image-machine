//
//  EditMachineViewController.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 23/12/22.
//

import UIKit

class EditMachineViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var codeNumberTextField: UITextField!
    
    private var machineDetails: Machine
    private var viewModel: EditMachineViewModels = EditMachineViewModels()
    
    init(_ machineDetails: Machine) {
        self.machineDetails = machineDetails
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Edit Machine"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        idTextField.isEnabled = false
        
        viewModel.delegate = self
        
        populateTextField()
    }
    
    private func populateTextField() {
        idTextField.text = String(machineDetails.id)
        nameTextField.text = machineDetails.name
        typeTextField.text = machineDetails.type
        codeNumberTextField.text = String(machineDetails.codeNumber)
    }
    
    private func validateTextFields() -> Bool {
        var isValidated: Bool = true
        
        let textFieldArray: [UITextField] = [
            idTextField, nameTextField, typeTextField, codeNumberTextField
        ]
        
        for item in textFieldArray where item.text?.isEmpty ?? false {
            isValidated = false
            break
        }
        
        return isValidated
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        if validateTextFields() {
            let machineData: Machine = Machine(
                id: Int(idTextField.text ?? "") ?? 0,
                name: nameTextField.text ?? "",
                type: typeTextField.text ?? "",
                lastUpdated: Date(),
                codeNumber: Int(codeNumberTextField.text ?? "") ?? 0
            )
            viewModel.updateMachine(machineData)
        } else {
            self.displaySimpleAlert(title: "Error!", message: "Please fill in all the fields!")
        }
    }
    
}

extension EditMachineViewController: EditMachineViewModelsDelegate {
    func updateMachineFinished() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Success!", message: "The machine has been updated in your database!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { [weak self] UIAlertAction in
                self?.navigationController?.popToRootViewController(animated: true)
            }
            
            alert.addAction(okAction)

            self?.present(alert, animated: true, completion: nil)
        }
    }
}
