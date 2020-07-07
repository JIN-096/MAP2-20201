# 모바일 앱프로그래밍2
## Team3 - KNU CSE PUZZLE

### What we do?
학부내에 있는 공지사항과 학생들이 주로 이용하는 페이지 시간표, 졸업 요건 등 여러가지를 하나로 볼 수 있는 어플리케이션을 개발합니다.
![splash](https://user-images.githubusercontent.com/41224549/86783946-e43eb480-c09b-11ea-8e46-41677fcc46e6.PNG)


### Why?
학부생들이 주로 이용하는 페이지들을 정해져 있지만 이것들을 웹상에 무수히 흩어져 있습니다. 이것들을 하나에 합쳐서 하나의 어플리케이션으로 모두 서비스 하기 위해서 만들게 되었습니다.

### How?
-- IOS Application
- IOS(Swift)를 이용하여 모든 데이터를 어플리케이션을 통해 볼 수 있도록 하였습니다. 한눈에 모든 정보를 알아볼 수 있고 여러 웹사이트를 옮겨 다니지 않아도 모든 서비스를 알 수 있습니다.

-- Crawling
- Alamofire와 SwiftSoup을 이용하여 웹상의 데이터를 크롤링하고 html parsing을 통하여 데이터를 모았습니다.

### So?
수업시간에 배운 여러가지 IOS 요소등의 활용법을 정확히 숙지하고 다른 프로젝트 진행시 이것을 응용하여 활용할 수 있도록 합니다. 

### Architecture
프로젝트 전체 구조는 다음과 같습니다.
![architecture](https://user-images.githubusercontent.com/41224549/86785652-ebff5880-c09d-11ea-8242-f69f21be81bf.PNG)


### 크롤링 & HTML-Parser
![alamofire](https://user-images.githubusercontent.com/41224549/86786392-e7876f80-c09e-11ea-9149-6acc12cd1104.PNG)

Alamofire를 이용하여 비동기 통신을 통해 http request 요청으로 html document 값을 얻어 옵니다.

![swiftsoup](https://user-images.githubusercontent.com/41224549/86786383-e5251580-c09e-11ea-8de9-f9bd7bae9b55.PNG)


얻어온 html document를 swiftsoup을 이용하여 html-parsing을 통해 필요한 데이터들을 다시 분류해서 모읍니다.



## 주요 기능

### 성적
<img src="https://user-images.githubusercontent.com/41224549/86787222-d854f180-c09f-11ea-9177-4717d3e4c5b4.PNG" width="300" height="550">

지금까지 이수한 성적을 한눈에 확인 가능

### 시간표
<img src="https://user-images.githubusercontent.com/41224549/86787224-d8ed8800-c09f-11ea-82d4-9b4882645c10.PNG" width="300" height="550">

이번학기에 수강하는 과목들에 대한 시간표를 바로 볼 수 있음

### 공지사항
<img src="https://user-images.githubusercontent.com/41224549/86787226-d9861e80-c09f-11ea-9ef1-878fec1528ea.PNG" width="300" height="550">

학부내에 있는 공지사항들을 볼 수 있으며 자세항 사항을 웹 뷰를 이용하여 확인할 수 있도록 함

### 학사일정
<img src="https://user-images.githubusercontent.com/41224549/86787228-d9861e80-c09f-11ea-88b6-a4ee6eda40b7.PNG" width="300" height="550">

학교내에서 진행되는 주요 학사 일정들을 한눈에 보고 파악할 수 있음

### 경력관리
<img src="https://user-images.githubusercontent.com/41224549/86787209-d5f29780-c09f-11ea-9917-9a02ac7e89cf.PNG" width="300" height="550">

자신의 졸업 요건들을 파악하여 졸업을 하기 위한 남은 것들에 대해 파악 가능

### 마일리지
<img src="https://user-images.githubusercontent.com/41224549/86787221-d854f180-c09f-11ea-9778-5e38a30a1039.PNG" width="300" height="550">


학부생들이 주로 이용하는 마일리지 서비스를 이 어플리케이션을 통해 확인 할 수 있도록 제공함.
