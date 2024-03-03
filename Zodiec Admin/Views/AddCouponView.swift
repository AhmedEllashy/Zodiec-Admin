//
//  AddCouponView.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 26/01/2024.
//

import SwiftUI

struct AddCouponView: View {
    //MARK: - Properties

    let bounds  = UIScreen.main.bounds
    @State private var code : String = ""
    @State private var discount : String = ""
    @State private var responseMessage : String = ""
    @State private var showLoadingAlert : Bool = false
    @State private var showeAlert : Bool = false
    @State private var alertState : AlertView.Sort = .loading


    var body: some View {
        NavigationView{
            ZStack {
                VStack(spacing : AppSizes.s20){

                    //MARK: - COUPON Image
                    Image("coupon-card")
                        .resizable()
                        .frame(width: bounds.width - AppSizes.s20, height: bounds.height / 3 , alignment: .center)
                        
                    //MARK: - TextFields
                        RectangleTextFieldShape()
                            .overlay(TextField(AppStrings.code, text: $code).padding(.horizontal,AppSizes.s20))
                        RectangleTextFieldShape()
                            .overlay(TextField(AppStrings.discount, text: $discount).padding(.horizontal,AppSizes.s20))
                    
                    //MARK: - Save Button
                    Button(AppStrings.save){
                        showeAlert = true
                        alertState = .loading
                        AppConstants.apiManager.addCoupon(completion: { data, error in
                            if let error = error {
                                alertState = .error
                                responseMessage = error as! String
                            }else{
                                alertState = .success
                                responseMessage = data as! String
                            }
                        }, coupon: CouponModel(id: nil, code: code, discount: Double(discount)))
                    }
                    .foregroundColor(.white)
                    .frame(width: bounds.width - AppSizes.s20, height: AppSizes.s50)
                    .clipShape(Capsule())
                    .background(Color.black)
                    .cornerRadius(AppSizes.s10)
                    Spacer()

                }//:VSTACK
                if showeAlert {AlertView(alertState: alertState, message: responseMessage, showAlert: $showeAlert)}
            }//:ZSTACK
            .navigationTitle("Add Coupon")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct AddCouponView_Previews: PreviewProvider {
    static var previews: some View {
        AddCouponView()
    }
}
