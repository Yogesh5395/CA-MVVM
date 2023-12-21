//
//  ProductCell.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 10/12/23.
//

import UIKit

class ProductCell: UITableViewCell {
    
    
    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productRating: UIButton!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    
    var productVM: SingleProductViewModel? {
        didSet {
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productBackgroundView.clipsToBounds = false
        productBackgroundView.layer.cornerRadius = 15

        productImage.layer.cornerRadius = 10

        self.productBackgroundView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration() {
        guard let product = productVM else { return }
        productTitle.text = product.title
        productCategory.text = product.category
        productDescription.text = product.description
        productPrice.text = "$\(product.price)"
        productRating.setTitle("\(product.rating.rate)", for: .normal)
        
        if product.favourite {
            if let image = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal) {
                favouriteBtn.setImage(image, for: .normal)
            }
        }else{
            if let image = UIImage(systemName: "heart.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal) {
                favouriteBtn.setImage(image, for: .normal)
            }
        }
        
//        productImageView.setImage(with: product.image)
    }
    
}
