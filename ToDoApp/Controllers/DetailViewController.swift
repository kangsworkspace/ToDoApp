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
    
    // 데이터 매니저 사용
    let coreDataManager = CoreDataManager.shared
    
    // 디테일 뷰 사용
    let detailView = DetailView()
    
    // 디테일 뷰 화면에 띄우기
    override func loadView() {
        view = detailView
    }
    
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
        
        // 버튼 tag의 숫자 사용
        let buttonNum = sender.tag
        
        switch buttonNum {
        // 색깔 버튼
        case 1...4:
            colorButtonTapped(num: buttonNum)
        // SAVE 버튼
        case 5:
            saveButtonTapped(num: buttonNum)
        default:
            print("잘못된 tag = \(buttonNum)의 버튼이 눌렸습니다.")
        }
    }
    
    // 색 조정 버튼(tag == 1...4)이 눌렸을 때
    func colorButtonTapped(num: Int) {
        // 임시 숫자 저장
        self.temporaryNum = Int64(num)
        
        // 버튼 tag -> 색 정보 받아오기
        let color = MyColor(rawValue: Int64(num))
        
        // 텍스트뷰/저장(업데이트)버튼색 변경
        setupColorTheme(color: color)
        
        // 버튼 색상 새롭게 세팅
        clearButtonColors()
        
        // 눌려진 버튼 색상 설정
        setupColorButton(num: Int64(num))
    }
    
    // SAVE/UPDATE 버튼(tag == 5)이 눌렸을 때
    func saveButtonTapped(num: Int) {
        
        // 기존 데이터가 있을 때 ==> 기존 데이터 없데이트
        if let toDoData = self.toDoData {
            toDoData.memoText = detailView.mainTextView.text
            toDoData.color = temporaryNum ?? 1
            
            coreDataManager.updateToDo(newToDoDate: toDoData) {
                print("업데이트 완료")
            }
            
        } else {
            // 기존 데이터가 없는 경우 ==> 새로운 데이터 생성
            let memoText = detailView.mainTextView.text
            coreDataManager.saveToDoData(todoText: memoText, colorInt: temporaryNum ?? 1) {
                print("저장완료")
            }
            
        }
        // 버튼이 눌린 후 창 내리기
        self.navigationController?.popViewController(animated: true)
    }
}
