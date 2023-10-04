//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by Kang on 2023/10/04.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    // 싱글톤
    static let shared = CoreDataManager()
    private init() {}
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔터티 이름(코어 데이터에 저장된 객체)
    let modelName: String = "ToDoData"
    
    // [Read] - 코어데이터에 저장된 데이터 모두 읽어오기
    func getToDoListFromCoreData() -> [ToDoData] {
        
        // 리턴할 값 빈 배열로 초기화
        var toDoList: [ToDoData] = []
        
        // 임시 저장소 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            
            // 정렬순서를 요청서에 넘겨주기
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                // 임시저장소에서 요청서를 통해 데이터 가져오기(fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print("코어데이터 가져오기 실패")
            }
        }
        
        return toDoList
    }
    
    // [Create] - 코어데이터에 데이터 생성하기
    func saveToDoData(todoText: String?, colorInt: Int64, completion: @escaping () -> Void) {
        
        // 임시저장소 확인
        if let context = context {
            
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                // 임시저장소에 올라가게 할 객체 만들기(NSManagedObject ===> ToDoData)
                if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? ToDoData {
                    
                    // ToDoData에 실제 데이터 할당
                    toDoData.memoText = todoText
                    toDoData.date = Date() // 저장하는 순간의 날짜 생성
                    toDoData.color = colorInt
                    
                    // 코어저장소에 업로드
                    // appDelegate?.saveContext() 로도 가능
                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
        
        completion()
    }
    
    // [Delete] - 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 삭제)
    func deleteToDo(data: ToDoData, completion: @escaping () -> Void) {
        
        // 날짜 옵셔널 바인딩
        guard let date = data.date else {
            completion()
            return
        }
        
        // 임시저장소 확인
        if let context = context {
            
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            
            // 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터)
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기
                    if let targetToDo = fetchedToDoList.first {
                        
                        // 삭제 메서드
                        context.delete(targetToDo)
                        
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로도 가능
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("삭제 실패")
                completion()
            }
        }
    }
    
    
    // [Update] - 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 수정)
    func updateToDo(newToDoDate: ToDoData, completion: @escaping () -> Void) {
        
        // 날짜 옵셔널 바인딩
        guard let date = newToDoDate.date else {
            completion()
            return
        }
        
        // 임시저장소 확인
        if let context = context {
            
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            
            // 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해 데이터 가져오기
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    
                    // 배열의 첫번째
                    if var targetToDo = fetchedToDoList.first {
                        
                        // 새로운 데이터 할당
                        targetToDo = newToDoDate
                        
                        //appDelegate?.saveContext() 앱델리게이트의 메서드로도 가능
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("업데이트 실패")
                completion()
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
