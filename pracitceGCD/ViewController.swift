/*

    ViewController.swift
    pracitceGCD

    Created by Dongju Park on 2023/01/25.
 
    DispatchQueue.main : UI 처리 담당
    main thread 실행 평소 thread를 사용하지 않은다면 main에서 동작된다고 생각하면 된다.
    
    DispatchQueue.global : 여러개의 쓰레드로 테스크를 나누어 동시에(concurrent) 처리함
    QoS(Quality of Service)에 따라 6종류로 나뉜다.
    userInteractive, userInitiated, default, utility, background, unspecified


*/

import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView = {
        var mainImageView = UIImageView()
        mainImageView.backgroundColor = .blue
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return mainImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 230),
        ])

        //서버로부터 이미지를 다운받는 함수/search
        func downloadImageFromServer() -> UIImage {
            //서버로부터 이미지를 가져왔다고 가정
            let img: UIImage = UIImage(named: "dog.jpeg")!
            return img
        }

        //컴포넌트들의 UI 상태를 업데이트 해주는 함수
        func updateUI(image: UIImage) {
            imageView.image = image
        }
        DispatchQueue.global(qos: .background).async {

            let image = downloadImageFromServer()
            DispatchQueue.main.async {
                updateUI(image: image)
            }
        }
    }
}


//// 유저와 직접 인터렉티브 : UI관련 (즉시)
//DispatchQueue.global(qos: .userInteractive).async {
//    <#code#>
//}
//
//// 반드시 필요, 비동기 처리 : 앱 내에서 첨부파일을 열기, 내부 데이터베이스 조회 등 (몇초)
//DispatchQueue.global(qos: .userInitiated).async {
//    <#code#>
//}
//
//// 일반적인 작업
//DispatchQueue.global().async {
//    <#code#>
//}
//
//// ProgressIndicator와 함께 길게 사용되는 작업 : 지속적인 데이터 feed, Networking (몇초~몇분)
//DispatchQueue.global(qos: .utility).async {
//    <#code#>
//}
//
//// 사용자가 직접적으로 인지하지 않는 부분 : 데이터베이스 유지 등 (속도보다는 에너지 효율성 중시)
//DispatchQueue.global(qos: .background).async {
//    <#code#>
//}
//
//// 사용하지 않음 legacy API
//DispatchQueue.global(qos: .unspecified).async {
//    <#code#>
//}
