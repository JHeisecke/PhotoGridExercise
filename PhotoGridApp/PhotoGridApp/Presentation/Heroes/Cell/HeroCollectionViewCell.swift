//
//  HeroCollectionViewCell.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import UIKit
import Kingfisher

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
            guard let urlString = hero?.image, let url = URL(string: urlString) else {
                self.heroImage.image = UIImage(named: "placeholder")
                return
            }
            self.heroImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder")
            )
        }
    }

    static let reusableIdentifier = "HeroCellId"
    static let nibName = "HeroCollectionViewCell"
}
