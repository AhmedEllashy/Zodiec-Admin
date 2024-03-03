//
//  AddCategoryView.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 27/12/2023.
//

import SwiftUI

struct AddCategoryView: View {
    @State private var image : UIImage = UIImage()
    @State private var name : String = ""
    @State private var isPhotoSelected : Bool = false
    @State private var isImagePickerPresented : Bool = false
    @State private var showProgressView : Bool = false
    @State private var showErrorView : Bool = false
    @State private var showSuccessView : Bool = false
    @State private var responseMessage : String = ""
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment : .center , spacing: AppSizes.s40){
                    //MARK: - Category Image
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
                    //MARK: - TextFieldView
                    RectangleTextFieldShape()
                        .overlay(TextField(AppStrings.name, text: $name).padding())
                    //MARK: - Save Button View
                    Button(AppStrings.save){
                        showProgressView = true
                        let category = CategoryModel(id: nil, name: name, imageUrl: nil)
                        saveCategory(category)
                    }
                    .foregroundColor(.white)
                    .frame(width:UIScreen.main.bounds.width - AppSizes.s20,height: AppSizes.s55, alignment: .center)
                    .clipShape(Capsule())
                    .background(Color.black)
                    .cornerRadius(AppSizes.s10)

                    Spacer()
             
                }//:VSTACK
                .navigationBarTitle(Text(AppStrings.addCategory))
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
                }
                //MARK: - AlertView
                if showProgressView {AlertView(alertState: .loading, showAlert: $showProgressView)}
                if showErrorView {AlertView(alertState: .error, message: responseMessage, showAlert: $showErrorView)}
                if showSuccessView {AlertView(alertState: .success, message: responseMessage, showAlert: $showSuccessView)}
            }//:ZSTACK
        }//:NavView
            
    }
    //MARK: - Functions
    func saveCategory(_ category : CategoryModel){
        AppConstants.apiManager.uploadImageToFireStorage(completion: { data, error in
            if let error = error {
                showProgressView = false
                responseMessage = error as! String
                showErrorView = true
                
            }else{
                category.imageUrl = data
                AppConstants.apiManager.addCategory(completion: { data, error in
                    if let error = error {
                        showProgressView = false
                        responseMessage = error as! String
                        showErrorView = true
                    }else{
                        showProgressView = false
                        responseMessage = AppStrings.productAddedSuccessfully
                        showSuccessView = true
                    }
                }, category: category)
            }
        }, imageCollectionName: AppStrings.categories, image: image)
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}
