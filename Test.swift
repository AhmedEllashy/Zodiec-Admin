//
//  Test.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 23/01/2024.
//

import SwiftUI

struct Test: View {
    enum Sort {
       case loading
       case error
       case success
    }
    var alertState : Sort?
    var message : String?
   @State var showAlert : Bool = false
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.75)
                .ignoresSafeArea()
            
             VStack(spacing: 20) {
                if alertState == .loading {
                    ProgressView()
                    Text("Loading...")
                }else{
                    VStack(spacing: 20) {
                       //TITLE
                        Text(alertState == .error ?"error" :"Success!!")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.black)
                    
                       //MESSAGE
                        Text(message ?? "i AM Nil")
                       //DISSMISS BUTTON
                        Button("Ok"){
                            print("dismissed")
                            showAlert = false
                        }
                        .frame(width: AppSizes.s80, height: AppSizes.s40, alignment: .center)
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10.0)
                   
                }
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: 300, height: 150)
            }
            .offset(y: -70)
        }
    
 
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test(alertState: .error, message: AppStrings.productAddedSuccessfully, showAlert: true)
    }
}
