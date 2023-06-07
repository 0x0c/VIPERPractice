//
//  ListCell.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Reusable
import NukeExtensions
import UIKit

class ListCell: UITableViewCell, NibReusable {
    @IBOutlet private  weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(for viewModel: ListCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        backgroundColor = viewModel.backgroundColor
        NukeExtensions.loadImage(
            with: viewModel.thumbnailURL,
            options: ImageLoadingOptions(transition: .fadeIn(duration: 0.25)),
            into: thumbnailImageView
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
