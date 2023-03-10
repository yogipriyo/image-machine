//
//  ImageCollectionViewCell.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 21/12/22.
//

import UIKit

protocol ImageCollectionViewCellDelegate {
    func deleteImage(imageId: Int)
    func openImage(mainImage: UIImage)
}

final class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    var imageId: Int = 0
    var mainImage: UIImage?
    var delegate: ImageCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupContent(_ image: UIImage, imageId: Int) {
        self.imageId = imageId
        self.mainImage = image
        thumbnailImageView.image = image
    }
    
    @IBAction func overlayImageButtonTapped(_ sender: UIButton) {
        guard let mainImage = mainImage else { return }
        self.delegate?.openImage(mainImage: mainImage)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        self.delegate?.deleteImage(imageId: imageId)
    }
    
}
