//
//  NoteCell.swift
//  Assignment 4 - Notes App 2
//
//  Created by Luka Khokhiashvili on 07.07.24.
//

import UIKit



class NoteCell: UICollectionViewCell {
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(headerLabel)
        contentView.addSubview(textLabel)
        
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.75
        contentView.layer.borderColor = UIColor.systemGray.cgColor
        contentView.layer.masksToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
                    headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                    headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                    headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                    
                    textLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
                    textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                    textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                    textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
                ])
    }
    
    func configure(note: NoteEntity) {
        headerLabel.text = note.noteheader
        textLabel.text = note.notetext
    }
    
    func calculateHeight(for width: CGFloat) -> CGFloat {
        let targetSize = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        let height = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
//        if height > 200 {
//            return 200
//        }
        return height
    }
    
}
