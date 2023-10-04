//
//  DetailView.swift
//  ToDoApp
//
//  Created by Kang on 2023/10/04.
//

import UIKit

class DetailView: UIView {
    
    
    var redButton: UIButton = {
        let button = UIButton()
        button.setTitle("RED", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = button.bounds.height / 2
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var greenButton: UIButton = {
        let button = UIButton()
        button.setTitle("GREEN", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = button.bounds.height / 2
        button.tag = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var blueButton: UIButton = {
        let button = UIButton()
        button.setTitle("BLUE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = button.bounds.height / 2
        button.tag = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var purpleButton: UIButton = {
        let button = UIButton()
        button.setTitle("PURPLE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = button.bounds.height / 2
        button.tag = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 15
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var mainTextView: UITextView = {
        let tv = UITextView()
        tv.autocorrectionType = .no
        tv.autocapitalizationType = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var saveButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("SAVE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tag = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 셋업 - 메인
    func setupMain() {
        self.backgroundColor = .white
        mainTextView.delegate = self
        
        setupAddView()
        setupAutoLayout()
    }
    
    // 다른 곳을 터치하면 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    // 셋업 애드 뷰
    func setupAddView() {
        
        buttonStackView.addArrangedSubview(redButton)
        buttonStackView.addArrangedSubview(greenButton)
        buttonStackView.addArrangedSubview(blueButton)
        buttonStackView.addArrangedSubview(purpleButton)
        
        backView.addSubview(mainTextView)
        
        self.addSubview(buttonStackView)
        self.addSubview(backView)
        self.addSubview(saveButton)
    }
    
    // 셋업 - 오토 레이아웃
    func setupAutoLayout() {
        
        //buttonStackView 오토 레이아웃
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            buttonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            
            buttonStackView.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        // backView 오토 레이아웃
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 40),
            backView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            backView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            
            backView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // mainTextView 오토 레이아웃
        NSLayoutConstraint.activate([
            mainTextView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15),
            mainTextView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15),
            mainTextView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -15),
            mainTextView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15),
        ])
        
        // saveButton 오토 레이아웃
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 40),
            saveButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            saveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension DetailView: UITextViewDelegate {
    // 입력을 시작할때
    // (텍스트뷰는 플레이스홀더가 따로 있지 않아서, 플레이스 홀더처럼 동작하도록 직접 구현)
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "텍스트를 여기에 입력하세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "텍스트를 여기에 입력하세요."
            textView.textColor = .lightGray
        }
    }
}
