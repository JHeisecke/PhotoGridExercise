//
//  HeroCollectionViewCell.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import UIKit
import Sniffer

class HeroCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var hero: HeroEntity? {
        didSet {
            self.heroName.text = hero?.name
            self.heroImage.layer.cornerRadius = 10
            guard let imageString = hero?.image else {
                self.heroImage.image = UIImage(named: "placeholder")
                return
            }
            self.heroImage.image = UIImage(named: "placeholder")
            self.heroImage.loadFrom(urlString: imageString)
        }
    }

    static let reusableIdentifier = "HeroCellId"
    static let nibName = "HeroCollectionViewCell"
}
