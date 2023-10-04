//
//  ViewController.swift
//  ToDoApp
//
//  Created by Kang on 2023/10/03.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - 선언/생성
    // 선언 - 테이블 뷰
    private let tableView = UITableView()
    
    // 선언 - 코어 데이터 매니저
    let coreDataManager = CoreDataManager.shared
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMain()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 화면에 재진입 할 때 -> 테이블 뷰 데이터 리로드
        tableView.reloadData()
    }
    
    
    // MARK: - 셋업
    // 셋업 - 메인
    func setupMain() {
        setupBackroundColor()
        setupNavigationBar()
        setUpTableView()
        setupTableViewAutoLayout()
    }
    
    // 셋업 - 뷰 백그라운드 컬러
    func setupBackroundColor() {
        view.backgroundColor = .white
    }
    
    // 셋업 - 네비게이션 바
    func setupNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 34, weight: .bold)]
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // 네비게이션바 우측에 PLUS 버튼 만들기
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
        navigationItem.title = "메모"
    }
    
    // 셋업 - 테이블 뷰
    func setUpTableView() {
        // 델리게이트 패턴, 데이터 처리 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        // 테이블뷰의 선 없애기
        tableView.separatorStyle = .none

        // 셀 등록
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoCell")
    }
    
    // 셋업 - 테이블 뷰 오토 레이아웃
    func setupTableViewAutoLayout() {
            
        // 뷰에 테이블 뷰 추가
        view.addSubview(tableView)
            
        // 오토 레이아웃 설정
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    // MARK: - 함수
    @objc func plusButtonTapped() {
        print("플러스 버튼이 눌렸습니다.")
        let detailVC = DetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - 확장
// 확장 - 테이블 뷰 DataSource
extension ViewController: UITableViewDataSource {
    
    // 1) 테이블뷰에 몇개의 데이터를 표시할 것인지(셀이 몇개인지)를 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.getToDoListFromCoreData().count
    }
    
    // 2) 셀의 구성(셀에 표시하고자 하는 데이터 표시)을 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        // (힙에 올라간)재사용 가능한 셀을 꺼내서 사용
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
        // toDoData 가져오기
        let toDoData = coreDataManager.getToDoListFromCoreData()
        // cell에 toDoData 입력
        cell.toDoData = toDoData[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

// 확장 - 테이블 뷰 델리게이트
extension ViewController: UITableViewDelegate {
    
    // 셀이 선택이 되었을때 어떤 동작을 할 것인지 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 다음화면으로 이동
        print("\(indexPath.row)번째 Cell이 눌렸습니다.")
        let detailVC = DetailViewController()
        // detailVC.movieData = moviesArray[indexPath.row]
        //show(detailVC, sender: nil)
        
        //    셀 높이 유동적으로 조절
        //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return UITableView.automaticDimension
        //    }
    }
}
