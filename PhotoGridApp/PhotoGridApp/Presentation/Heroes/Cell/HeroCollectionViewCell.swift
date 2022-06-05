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
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var deleteButton: UIButton!

    var deleteButtonPressed: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var hero: HeroEntity? {
        didSet {
            guard let hero = hero else { return }
            self.deleteButton.setTitle("", for: .normal)
            self.detailsView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.heroName.text = hero.name
            self.powerLabel.text = "\(hero.power)"
            self.speedLabel.text = "\(hero.speed)"
            self.intelligenceLabel.text = "\(hero.intelligence)"
            self.heroImage.layer.cornerRadius = 10
            guard let url = URL(string: hero.image) else {
                self.heroImage.image = UIImage(named: "placeholder")
                return
            }
            self.heroImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder")
            )
        }
    }

    @IBAction func deletePressed(_ sender: Any) {
        deleteButtonPressed?()
    }

    static let reusableIdentifier = "HeroCellId"
    static let nibName = "HeroCollectionViewCell"
}
