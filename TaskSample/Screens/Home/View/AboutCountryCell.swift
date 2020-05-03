//
//  AboutCountryCell.swift
//  TaskSample
//
//  Created by Praveen Reddy on 03/05/20.
//  Copyright © 2020 Praveen Reddy. All rights reserved.
//

import UIKit

class AboutCountryCell: UITableViewCell {

   static let reuseIdentifier = "AboutCountryCell"
       private var task: URLSessionDataTask?
           
       let cellImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
           imageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
           imageView.layer.cornerRadius = 2
           imageView.clipsToBounds = true
          return imageView
       }()
       
       let cellTitleLabel:UILabel = {
               let label = UILabel()
               label.numberOfLines = 0
               label.font = UIFont.preferredFont(forTextStyle: .title3)
               label.textColor =  UIColor.darkText
               label.translatesAutoresizingMaskIntoConstraints = false
               return label
       }()
       
       let cellDescriptionLabel:UILabel = {
               let label = UILabel()
               label.numberOfLines = 0
               label.font = UIFont.preferredFont(forTextStyle: .body)
               label.textColor =  UIColor.darkGray
               label.translatesAutoresizingMaskIntoConstraints = false
               return label
       }()
       
       private let AVATAR_SIZE = 70

       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           self.setupViews()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       override func prepareForReuse() {
           super.prepareForReuse()

           task?.cancel()
           task = nil
           cellImageView.image = nil
       }
       
       fileprivate func setupViews() {
           
           contentView.addSubview(cellImageView)
           contentView.addSubview(cellTitleLabel)
           contentView.addSubview(cellDescriptionLabel)
           
           let views = [
               "cellImageView" : cellImageView,
               "cellTitleLabel"  : cellTitleLabel,
               "cellDescriptionLabel" : cellDescriptionLabel,
           ]
           
           var allConstraints: [NSLayoutConstraint] = []
           allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[cellImageView(\(AVATAR_SIZE))]-(>=12)-|", options: [], metrics: nil, views: views)
           allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[cellTitleLabel]-[cellDescriptionLabel]-|", options: [], metrics: nil, views: views)
           allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[cellImageView(\(AVATAR_SIZE))]-[cellTitleLabel]-|", options: [], metrics: nil, views: views)
           allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[cellImageView]-[cellDescriptionLabel]-|", options: [], metrics: nil, views: views)
           
            NSLayoutConstraint.activate(allConstraints)
       }

       public func update(row: Row) {
           cellTitleLabel.text = row.titleString
           cellDescriptionLabel.text = row.descriptionString
           cellImageView.image = UIImage(named: "placeholder")
           if task == nil {
               // Ignore calls when reloading
               task = cellImageView.downloadImage(row.imageHref)
           }
       }
       
   }

