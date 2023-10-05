//
//  ToDoTableViewCell.swift
//  ToDoApp
//
//  Created by Kang on 2023/10/04.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    // toDoData 사용
    var toDoData: ToDoData? {
        didSet {
            configureUIwithData()
        }
    }
    
    // 뷰컨트롤러에 있는 클로저 저장할 예정(자신을 전달)
    var updateButtonPressed: (ToDoTableViewCell) -> Void = { (sender) in }
    
    lazy var backView: UIView = {
        let view = UIView()
        view.addSubview(stackView)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var subBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var toDoTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var updateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.tintColor = .white
        button.setTitle("UPDATE ", for: .normal)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var dateTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        // let sv = UIStackView(arrangedSubviews: [toDoTextLabel, subBackView])
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        setupMain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 셋업 - 메인
    func setupMain() {
        
        // contentsView 뒤로 보내기
        sendSubviewToBack(contentView)
        
        setupConfigureUI()
        setupAddView()
        setupAutoLayout()
    }
    
    // 셋업 - 기본 UI
    func setupConfigureUI() {
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 8
        
        updateButton.clipsToBounds = true
        updateButton.layer.cornerRadius = 10
    }
    
    // 셋업 - 애드뷰
    func setupAddView() {
        
        subBackView.addSubview(dateTextLabel)
        subBackView.addSubview(updateButton)
        
        stackView.addArrangedSubview(toDoTextLabel)
        stackView.addArrangedSubview(subBackView)

        self.addSubview(backView)
        self.addSubview(stackView)
    }
    
    // 셋업 - 오토 레이아웃
    func setupAutoLayout() {
        
        // backView 오토 레이아웃
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25)
        ])
        
        // stackView 오토 레이아웃
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10),
            stackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10)
        ])
        
        // toDoTextLabel 오토 레이아웃
        NSLayoutConstraint.activate([
            toDoTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        // subBackView 오토 레이아웃
        NSLayoutConstraint.activate([
            subBackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // dateTextLabel 오토 레이아웃
        NSLayoutConstraint.activate([
            dateTextLabel.leadingAnchor.constraint(equalTo: subBackView.leadingAnchor, constant: 0),
            dateTextLabel.bottomAnchor.constraint(equalTo: subBackView.bottomAnchor, constant: 0)
        ])
        
        // updateButton 오토 레이아웃
        NSLayoutConstraint.activate([
            updateButton.widthAnchor.constraint(equalToConstant: 70),
            updateButton.heightAnchor.constraint(equalToConstant: 26),
            updateButton.bottomAnchor.constraint(equalTo: subBackView.bottomAnchor, constant: 0),
            updateButton.trailingAnchor.constraint(equalTo: subBackView.trailingAnchor, constant: 0)
        ])
    }
    
    // updateButton이 눌렸을 때
    @objc func updateButtonTapped() {
        print("updateButton이 눌렸습니다.")
        updateButtonPressed(self)
    }
    
    // 데이터를 통해 UI 표시하기
    func configureUIwithData() {
        toDoTextLabel.text = toDoData?.memoText
        dateTextLabel.text = toDoData?.dateString
        guard let colorNum = toDoData?.color else { return }
        let color = MyColor(rawValue: colorNum) ?? .red
        updateButton.backgroundColor = color.buttonColor
        backView.backgroundColor = color.backgoundColor
    }

}
