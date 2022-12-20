//
//  MachineTableViewCell.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 21/12/22.
//

import UIKit

final class MachineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var lastMaintenanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }

    private func setupViews() {
        selectionStyle = .none
        contentContainerView.layer.cornerRadius = 8
    }
    
    func setupContent(_ data: Machine) {
        nameLabel.text = data.name
        typeLabel.text = data.type
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        lastMaintenanceLabel.text = formatter.string(from: data.lastUpdated)
    }
    
}
