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
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var machineImageButton: UIButton!
    
    private var imageList: [UIImage] = []
    private var imageIds: [Int] = []
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
        retrieveImages()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setupCollectionView()
        
        populateContent()
        
        setupViews()
    }
    
    private func setupViews() {
        editButton.tintColor = .white
        editButton.layer.cornerRadius = 4
        
        deleteButton.tintColor = .white
        deleteButton.layer.cornerRadius = 4
        
        machineImageButton.tintColor = .white
        machineImageButton.layer.cornerRadius = 4
    }
    
    private func setupCollectionView() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(UINib(nibName: CollectionViewCellIdentifier.imageListCellId, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellIdentifier.imageListCellId)
    }
    
    private func populateContent() {
        machineIdLabel.text = String(machineDetails.id)
        machineNameLabel.text = machineDetails.name
        machineTypeLabel.text = machineDetails.type
        machineCodeNumberLabel.text = String(machineDetails.codeNumber)
    }
    
    private func saveImage(selectedImage: UIImage, imageId: Int) {
        if let imageData = selectedImage.pngData() {
            viewModel.saveImage(selectedImage: imageData, machineId: machineDetails.id, imageId: imageId)
        }
    }
    
    private func retrieveImages() {
        imageList = []
        imageIds = []
        viewModel.getImages(machineId: machineDetails.id)
    }
    
    private func constructImageArray(_ datas: [Data]) {
        for data in datas {
            guard let image = UIImage(data: data) else { return }
            imageList.append(image)
            imagesCollectionView.reloadData()
        }
    }
    
    @IBAction func machineImageTapped(_ sender: UIButton) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 10
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        let editMachineVC: EditMachineViewController = EditMachineViewController(machineDetails)
        self.navigationController?.pushViewController(editMachineVC, animated: true)
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
    func retrievedImages(datas: [Data], ids: [Int]) {
        DispatchQueue.main.async { [weak self] in
            if datas.isEmpty {
                self?.imagesCollectionView.reloadData()
            } else {
                self?.constructImageArray(datas)
                self?.imageIds = ids
            }
        }
    }
    
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
    
    func imageSaved() {
        DispatchQueue.main.async { [weak self] in
            print("image has been saved")
        }
    }
    
    func imageDeleted() {
        DispatchQueue.main.async { [weak self] in
            self?.displaySimpleAlert(title: "Success!", message: "Image has been removed!")
            self?.retrieveImages()
        }
    }
}

extension MachineDetailsViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        let itemProviders = results.map(\.itemProvider)
        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            let randomNumber = Int.random(in: 10000...99999)
                            self?.imageList.append(image)
                            self?.imageIds.append((self?.machineDetails.id ?? 0)+randomNumber)
                            self?.imagesCollectionView.reloadData()
                            
                            self?.saveImage(
                                selectedImage: image,
                                imageId: (self?.machineDetails.id ?? 0)+randomNumber
                            )
                        }
                    }
                }
            }
        }
        
        imagesCollectionView.reloadData()
    }
}

extension MachineDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCellIdentifier.imageListCellId,
            for: indexPath
        ) as? ImageCollectionViewCell
        cell?.setupContent(imageList[indexPath.row], imageId: imageIds[indexPath.row])
        cell?.delegate = self
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
}

extension MachineDetailsViewController: ImageCollectionViewCellDelegate {
    func openImage(mainImage: UIImage) {
        let imageDetailsVC: ImageDetailsViewController = ImageDetailsViewController(mainImage)
        self.navigationController?.pushViewController(imageDetailsVC, animated: true)
    }
    
    func deleteImage(imageId: Int) {
        viewModel.deleteImage(imageId)
    }
}
