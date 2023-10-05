# ToDoApp

## 🖥️ 프로젝트 소개

- 입력한 문자열과 선택한 색깔을 저장하기/수정하기 기능을 가진 메모 앱입니다.
- CoreData 기능을 사용하여 입력한 데이터를 저장하고 불러오는 기능을 처리하였습니다.


<br>

## 👀 프로젝트 구성

- CoreData에 저장한 데이터를 보여주는 TableView
  
- 새로운 데이터(메모)를 입력하고 저장하는 DetailView

- TableView에 있는 기존 데이터를 불러와 수정할 수 있는 UpdateButton

<br>

## 📌 학습한 주요 내용

#### CoreData
데이터 관리 프레임워크인 CoreData를 사용해 로컬 저장소에 데이터를 저장/수정하는 기능을 사용하였습니다.
CoreData의 Entity 생성하고 CoreDataManager 클래스를 생성하여 코드로 관리하는 방법을 학습하였습니다.
요청서를 생성하고 .fetch를 통해 CoreData에 접근하여 데이터를 처리하는 법을 학습하였습니다.



## 🎬 완성된 모습
![1-2](https://github.com/kangsworkspace/DataStorage/assets/141600830/2c2a9fa5-31d0-42c1-b3d7-491bf632b517)
![2-2](https://github.com/kangsworkspace/DataStorage/assets/141600830/517afa20-53db-4e98-ac70-24a01d7688cf)
![3-2](https://github.com/kangsworkspace/DataStorage/assets/141600830/067a499c-d0d2-48b2-b51b-2cea666ffa07)
![4-2](https://github.com/kangsworkspace/DataStorage/assets/141600830/0d88024c-a91e-4fb1-85ff-6cbfa8ac690b)
![5-2](https://github.com/kangsworkspace/DataStorage/assets/141600830/7627ab34-262a-4abb-9d64-3fa0c51b2920)

## 🙉 문제점 및 해결

#### MVC 패턴 - UIButton처리

처음에 명확한 규칙 없이 MVC에 대한 대략적인 개념만 이해하고 MVC 패턴을 적용시키다 패턴을 적용시키는 것을 실패하였습니다.
MVC패턴으로 프로젝트를 진행하는중 버튼을 누르면 색깔이 바뀌는 기능은 간단한 UI처리이기 때문에 View에서 기능을 처리하였습니다.
하지만 색깔이 바뀌는 기능을 처리하기 위해서는 색의 번호를 저장하는 temporaryNum 변수가 필요했고 이 변수는 CoreData에 정보를 저장하는 save버튼에도 필요했습니다.
따라서 Controller에서 save 버튼을 처리하려면 중복되는 변수를 선언하거나 View에 있는 변수를 이용해야 하는데 MVC패턴과 거리가 먼 방법인 View에서 직접 save 버튼을 처리하는 방식을 채택했습니다.
그리고 save 버튼이 눌린 후 이전 창으로 돌아가는 과정을 Controller에서 구현하기 위해 커스텀 델리게이트를 만들어 save 버튼이 눌렸을 때의 함수를 만들었습니다.
git에 올리기 위해 프로젝트를 다시 처음부터 만들면서 해당 기능의 코드들이 과하게 복잡하게 처리되어 있는 것을 발견하였습니다.
MVC 패턴에 대한 이해가 부족하기 때문에 코드를 어디서 어떻게 처리해야 하는지를 혼란스럽게 처리한 과정이 코드에 나타났다고 판단했고
MVC패턴에 대해 더 자세히 찾아보았습니다. 그리고 아래의 다섯가지 규칙을 적용하여 코드를 개선시켰습니다.

1. Model은 Controller와 View에 의존하지 않아야 한다.
2. View는 Model에만 의존해야 하고, Controller에는 의존하면 안 된다.
3. View가 Model로부터 데이터를 받을 때는, 사용자마다 다르게 보여주여야 하는 데이터에 대해서만 받아야 한다.
4. Controller는 Model과 View에 의존해도 된다.
5. View가 Model로부터 데이터를 받을 때, 반드시 Controller에서 받아야 한다.

조금 더 명확한 기준이 있어서 코드를 처리하는것에 대한 고민이 줄어들었습니다.
UIButton과 관련된 기능은 최대한 깔끔하게 처리해보자는 생각으로 일괄적으로 Controller에서 처리하였습니다.
그리고 UIButton에 .tag 기능을 활용하여 하나의 함수에서 switch문을 통해 .tag에 맞는 함수를 동작시키는 방법으로 코드를 정리하였습니다.
이러한 방식으로 정리했을 때 각각의 코드가 어떤 역할을 하는지가 더 명확하게 보였습니다.

#### 한글 모음과 자음 분리

![무제](https://github.com/kangsworkspace/DataStorage/assets/141600830/c9513f6d-a324-4b53-a280-9b0785b65b47)


한글을 입력했을 때 모음과 자음이 따로 눌리는 오류가 발생하였습니다.
여러 방법으로 조사해보았고 적용해보았지만 해결할 수 없었고 도움을 구할 수 있는 커뮤니티에 도움을 요청하였습니다.
그리고 xcode 최신 버전의 오류일 수 있다는 답변을 보고 안정성 있는 xcode 버전을 추천받아 프로젝트를 실행시켜보니 오류가 해결되었습니다.
이런 종류의 오류가 발생할 수 있음을 인식하였고 계속해서 업데이트 할 최신 버전과 안정성 있는 버전을 둘 다 관리하고 있습니다.

#### backView 위 버튼 안눌림

TableViewCell에 UIView타입의 backView를 선언하였고 .addSubView로 backView 위에 띄운 버튼이 동작하지 않았습니다.
UICell이 동작하는 것은 이미 확인하였고 view위에 올린 버튼을 올렸기 때문이라고 추측하고 문제를 해결할 방법을 찾았습니다.
기존에 신경쓰지 않았던 ContentView와 관련된 문제임을 찾았고 버튼의 레이아웃을 ContentView를 기준으로 잡으면 해결할 수 있었습니다.
하지만 기존에 완성해둔 오토 레이아웃도 전부 다시 설정해야해서 sendSubviewToBack(contentView)를 통해 contentView를 뒤로 보내 간단하게 해결했습니다.
