//
//  TodoCell.swift
//  Todo
//
//  Created by Decagon on 1/10/22.
//

import UIKit

class TodoCell: UITableViewCell {
    static let reuseIdentifier = "TodoCell"
    
    let todoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.italicSystemFont(ofSize: 10)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        todoLabel.text = nil
        dateLabel.text = nil
    }
    
    func configure(with todo: Todo) {
        updateUI(title: todo.title ?? "", date: todo.createdAt)
    }
    
    private func updateUI(title: String, date: Date) {
        todoLabel.text = title
        dateLabel.text = date.formatted(date: .complete, time: .shortened)
    }
    
    func setUpView() {
        self.addSubviews(todoLabel, dateLabel)
        NSLayoutConstraint.activate([
            todoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            todoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            todoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            dateLabel.topAnchor.constraint(equalTo: todoLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)

        ])
    }
}
