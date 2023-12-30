//
//  ViewController.swift
//  KakaoLogin
//
//  Created by 선상혁 on 2023/12/28.
//

import UIKit
import SnapKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class ViewController: UIViewController {
    
    private let kakaoLoginButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "kakao_login_medium_wide"), for: .normal)
        return view
    }()
    
    var accessToken: OAuthToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonPressed), for: .touchUpInside)
        
        view.addSubview(kakaoLoginButton)
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        //        UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
        //            if let error = error {
        //                print("========================", error)
        //            }
        //            else {
        //                print("accessTokenInfo() success.")
        //
        //                //do something
        //                print(accessTokenInfo)
        //            }
        //        }
    }
    
    @objc
    func kakaoLoginButtonPressed() {
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    // 예외 처리 (로그인 취소 등)
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    // do something
                    _ = oauthToken
                    // 어세스토큰
                    let accessToken = oauthToken?.accessToken
                    
                    //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                    self.setUserInfo()
                }
            }
            
            
            
        }
    
    }
    
    
    func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
                
            }
        }
    }
        
}
