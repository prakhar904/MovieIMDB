//
//  MovieTableViewCell.swift
//  MovieIMDB
//
//  Created by Prakhar Garg on 24/09/23.
//

import Foundation
import UIKit
import SDWebImage

protocol MovieDelegate: AnyObject{
    func playListButtonClicked()
}

class MovieTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MovieTableViewCell"
    weak var delegate: MovieDelegate?

    //MARK: - lifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    
    
    private lazy var headerStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "venom-7.jpg")
        return image
    }()
    
    private lazy var profileName: UIButton = {
        let button = UIButton(type: .system)
        button.isUserInteractionEnabled = true
        button.setTitle("venom", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    private lazy var thumbnailImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    // MARK: - Footer View
    
    private lazy var footerhorizontalStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 16
        return view
    }()
    
    private lazy var footerContentStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    private lazy var playListButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setImage(UIImage(systemName: "star")?.withTintColor(.black), for: .normal)
        button.addTarget(self, action: #selector(playListButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title Label"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rating Label"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var playListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "playList Label"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    
    //MARK: - Helper Functions
    
    private func setupViews(){
        
        // Adding extra view for the space in the end of StackView, otherwise button will expand
        
        contentView.addSubview(thumbnailImageView)
        
        contentView.addSubview(footerContentStackView)
        footerContentStackView.addArrangedSubview(footerhorizontalStackView)
        footerhorizontalStackView.addArrangedSubview(playListButton)
        footerhorizontalStackView.addArrangedSubview(UIView())
        
        footerContentStackView.addArrangedSubview(titleLabel)
        footerContentStackView.addArrangedSubview(ratingLabel)
        footerContentStackView.addArrangedSubview(playListLabel)
        
    }
    
    private func setupConstraints(){
        
        
        // Post Image Set Up according to image aspect ratio
        let size = thumbnailImageView.image?.size
        let ratio = (size?.height ?? 1)/(size?.width ?? 1)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            thumbnailImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: ratio)
        ])
        
        NSLayoutConstraint.activate([
            footerContentStackView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            footerContentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 16),
            footerContentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerContentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    @objc func playListButtonClicked(){
        delegate?.playListButtonClicked()
    }
    
    func configure(with movie: MovieModel) {
            titleLabel.text = movie.title
            ratingLabel.text = "Rating: \(movie.rating)"
            // Load thumbnail image using SDWebImage
                if let thumbnailURL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.thumbnail)") {
                    thumbnailImageView.sd_setImage(with: thumbnailURL, placeholderImage: UIImage(named: "placeholderImage"))
                } else {
                    // Set a placeholder image or handle the case when the URL is invalid
                    thumbnailImageView.image = UIImage(named: "placeholderImage")
                }
    
        }
}


