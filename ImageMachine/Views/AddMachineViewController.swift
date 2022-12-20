//
//  AddMachineViewController.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

import UIKit

class AddMachineViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var codeNumberTextField: UITextField!
    
    private var viewModel: AddMachineViewModels = AddMachineViewModels()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Add Machine"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        
        setupTextField()
    }
    
    private func setupTextField() {
        let randomNumber = Int.random(in: 10000...99999)
        idTextField.isEnabled = false
        idTextField.text = String(randomNumber)
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
    
    @IBAction func saveMachineButtonTapped(_ sender: UIButton) {
        if validateTextFields() {
            let machineData: Machine = Machine(
                id: Int(idTextField.text ?? "") ?? 0,
                name: nameTextField.text ?? "",
                type: typeTextField.text ?? "",
                lastUpdated: Date(),
                codeNumber: Int(codeNumberTextField.text ?? "") ?? 0
            )
            viewModel.saveMachine(machineData)
        } else {
            self.displayErrorAlert(title: "Error!", message: "Please fill in all the fields!")
        }
    }
    
}

extension AddMachineViewController: AddMachineViewModelsDelegate {
    func saveMachineFinished() {
        DispatchQueue.main.async { [weak self] in
            self?.displayErrorAlert(title: "Success!", message: "A machine has been created in your phone!")
        }
    }
}
