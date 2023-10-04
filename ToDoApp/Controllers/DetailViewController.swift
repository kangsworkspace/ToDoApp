//
//  DetailViewController.swift
//  ToDoApp
//
//  Created by Kang on 2023/10/04.
//

import UIKit

class DetailViewController: UIViewController {

    // ToDoData 사용
    var toDoData: ToDoData?
    
    // 디테일 뷰 사용
    let detailView = DetailView()
    
    // 디테일 뷰 화면에 띄우기
    override func loadView() {
        view = detailView
    }
    
    // 선언 - color 버튼 사용
    lazy var buttons: [UIButton] = {
        return [detailView.redButton, detailView.greenButton, detailView.blueButton, detailView.purpleButton, detailView.saveButton]
    }()
    
    // ToDo 색깔 구분을 위해 임시적으로 숫자저장하는 변수
    var temporaryNum: Int64? = 1

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMain()
    }
    
    func setupMain() {
        configureUIwithData()
        buttonsAddTarget()
    }
    
    func configureUIwithData() {
        if let toDoData = toDoData {
            // 기존의 데이터가 있을 경우
            self.title = "메모 수정하기"
            detailView.saveButton.setTitle("UPDATE", for: .normal)
            detailView.mainTextView.textColor = .black
            detailView.mainTextView.becomeFirstResponder()
            
            // toDoData 할당
            guard let memoText = toDoData.memoText else { return }
            detailView.mainTextView.text = memoText
            
            // color 설정
            let color = MyColor(rawValue: toDoData.color)
            setupColorTheme(color: color)
            
            
        } else {
            // 기존의 데이터가 없을 경우
            self.title = "새로운 메모 생성"
            detailView.saveButton.setTitle("SAVE", for: .normal)
            detailView.mainTextView.textColor = .lightGray
            setupColorTheme(color: .red)
        }
        setupColorButton(num: temporaryNum ?? 1)
    }
    
    func buttonsAddTarget() {
        detailView.redButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        detailView.greenButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        detailView.blueButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        detailView.purpleButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        detailView.saveButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        
    }
    
    // 텍스트뷰/저장(업데이트) 버튼 색상 설정
    func setupColorTheme(color: MyColor? = .red) {
        detailView.backView.backgroundColor = color?.backgoundColor
        detailView.mainTextView.backgroundColor = color?.backgoundColor
        detailView.saveButton.backgroundColor = color?.buttonColor
    }
    
    // 버튼 색상 새롭게 셋팅
    func clearButtonColors() {
        detailView.redButton.backgroundColor = MyColor.red.backgoundColor
        detailView.redButton.setTitleColor(MyColor.red.buttonColor, for: .normal)
        detailView.greenButton.backgroundColor = MyColor.green.backgoundColor
        detailView.greenButton.setTitleColor(MyColor.green.buttonColor, for: .normal)
        detailView.blueButton.backgroundColor = MyColor.blue.backgoundColor
        detailView.blueButton.setTitleColor(MyColor.blue.buttonColor, for: .normal)
        detailView.purpleButton.backgroundColor = MyColor.purple.backgoundColor
        detailView.purpleButton.setTitleColor(MyColor.purple.buttonColor, for: .normal)
    }
    
    // 눌려진 버튼 색상 설정
    func setupColorButton(num: Int64) {
        switch num {
        case 1:
            detailView.redButton.backgroundColor = MyColor.red.buttonColor
            detailView.redButton.setTitleColor(.white, for: .normal)
        case 2:
            detailView.greenButton.backgroundColor = MyColor.green.buttonColor
            detailView.greenButton.setTitleColor(.white, for: .normal)
        case 3:
            detailView.blueButton.backgroundColor = MyColor.blue.buttonColor
            detailView.blueButton.setTitleColor(.white, for: .normal)
        case 4:
            detailView.purpleButton.backgroundColor = MyColor.purple.buttonColor
            detailView.purpleButton.setTitleColor(.white, for: .normal)
        default:
            detailView.redButton.backgroundColor = MyColor.red.buttonColor
            detailView.redButton.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc func buttonTapped(sender: UIButton) {
        
        switch sender.tag {
        case 1:
            print("\(sender.tag)"의 버튼이 눌렸습니다.")
            return
                  case 1:
                      print("\(sender.tag)"의 버튼이 눌렸습니다.")
                      return
                            case 1:
                                print("\(sender.tag)"의 버튼이 눌렸습니다.")
                                return
                                      case 1:
                                          print("\(sender.tag)"의 버튼이 눌렸습니다.")
                                          return
                                                case 1:
                                                    print("\(sender.tag)"의 버튼이 눌렸습니다.")
                                                    return
            
        }
    }
}
