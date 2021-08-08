//
//  GalleryUICollectionViewCell.swift
//  DIAGNAL
//
//  Created by Aravind Kumar on 07/08/21.
//

import UIKit

class GalleryUICollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCellWith(content:ContentInformation) {
        //placeholder_for_missing_posters Reequire if we downlaod images from Server
        
        galleryImageView.clipsToBounds = true
        if let image = UIImage(named: content.posterImage)  {
            self.galleryImageView.image  = image
        }
        self.galleryImageView.contentMode = .scaleAspectFill;
        self.title.text = content.name
    }
}
