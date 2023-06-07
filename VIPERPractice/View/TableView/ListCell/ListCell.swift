//
//  ListCell.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import NukeExtensions
import Reusable
import UIKit

class ListCell: UITableViewCell, NibReusable {
    // MARK: Internal

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
        checkmarkImageView.isHidden = !viewModel.checked
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: Private

    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var checkmarkImageView: UIImageView!
}
