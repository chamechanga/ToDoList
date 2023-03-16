//
//  HourlyTempCollectionViewCell.swift
//  ToDoList
//
//  Created by Indra on 3/14/23.
//

import UIKit

class HourlyTempCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func set(time: String, temperature: String) {
        timeLabel.text = time
        temperatureLabel.text = temperature
    }
}
