//
//  AddBannerView.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 26/01/2024.
//

import SwiftUI

struct AddBannerView: View {
    @State private var isPhotoSelected : Bool = false
    @State private var image : UIImage = UIImage()
    @State private var showAlert : Bool = false
    @State private var isImagePickerPresented : Bool = false
    @State private var alertState : AlertView.Sort = .loading
    @State private var responseMessage : String = ""
    let bounds  = UIScreen.main.bounds

    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing : AppSizes.s20){
                    //MARK: - Banner Image
                    Group{
                        if !isPhotoSelected {
                            ZStack{
                                Color.black.opacity(0.1)
                                    .cornerRadius(AppSizes.s20)
                                    .padding(.horizontal,AppSizes.s10)
                                Image(systemName: "doc.fill.badge.plus")
                                    .font(.system(size: AppSizes.s100))
                                    .foregroundColor(.black.opacity(0.2))
                            }
                            .frame(height: AppSizes.s200, alignment: .center)
                            .onTapGesture {
                              isImagePickerPresented.toggle()
                              isPhotoSelected = true
                          }
                        }else{
                            Image(uiImage: image)
                              .resizable()
                              .cornerRadius(AppSizes.s20)
                              .frame(width: UIScreen.main.bounds.width - AppSizes.s20, height: AppSizes.s200, alignment: .center)

                        }
                    }
                    //MARK: - Save Button
                    Button(AppStrings.save){
                        showAlert = true
                        var bannerImageUrl = ""
                        guard !image.description.isEmpty else {
                            alertState = .error
                            responseMessage = "Error Please Add Image!"
                            return
                        }
                        AppConstants.apiManager.uploadImageToFireStorage(completion: { imgData, error in
                            if let error = error {
                                alertState = .error
                                responseMessage = error as! String
                            }else{
                                
                                bannerImageUrl = imgData!
                            }
                        }, imageCollectionName: AppStrings.banners, image: image)
                        
                        AppConstants.apiManager.addBanner(completion: { data, error in
                            if let error = error {
                                alertState = .error
                                responseMessage = error as! String
                            }else{
                                alertState = .success
                                responseMessage = AppStrings.success
                            }
                            
                        }, banner: BannerModel(_id: nil, _imageUrl: bannerImageUrl))
                        

                    }
                    .foregroundColor(.white)
                    .frame(width: bounds.width - AppSizes.s20, height: AppSizes.s50)
                    .clipShape(Capsule())
                    .background(Color.black)
                    .cornerRadius(AppSizes.s10)
                    Spacer()
                }//:VSTACK
                .navigationTitle(AppStrings.banners)
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
                }
                if showAlert {AlertView(alertState: alertState, message: responseMessage, showAlert: $showAlert)}
            }//:ZSTACK
        }//:NAV View
        
    }
}

struct AddBannerView_Previews: PreviewProvider {
    static var previews: some View {
        AddBannerView()
    }
}
