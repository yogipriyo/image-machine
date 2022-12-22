//
//  ImageCollectionViewCell.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 21/12/22.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupContent(_ image: UIImage) {
        thumbnailImageView.image = image
    }

    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        
    }
    
}
