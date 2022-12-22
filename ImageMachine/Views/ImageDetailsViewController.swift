//
//  ImageDetailsViewController.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 22/12/22.
//

import UIKit

class ImageDetailsViewController: UIViewController {
    
    private var mainImage: UIImage
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    init(_ mainImage: UIImage) {
        self.mainImage = mainImage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainImageView.image = mainImage
    }

}
