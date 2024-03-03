//
//  AddProductView.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 27/12/2023.
//
import PhotosUI
import SwiftUI
import FirebaseStorage
struct AddProductView: View {
    //MARK: - Property
    @State private var image = UIImage()
    @State private var isPhotoPickerPresented = false
    @State private var isPhotoSelected = false
    @State private var name : String = ""
    @State private var category : String = ""
    @State private var price : String = ""
    @State private var quantity : String = ""
    @State private var description : String = ""
    @State private var showAlert : Bool = false
    @State private var product : ProductModel?
    @State private var imagePicker : ImagePicker?
    @State private var showProgressView : Bool = false
    @State private var showErrorView : Bool = false
    @State private var showSuccessView : Bool = false
    @State private var responseMessage : String = ""

    @ViewBuilder
    var body: some View {
        NavigationView{
            ZStack {
                VStack(alignment:.center , spacing: AppSizes.s30){
                 //MARK: - Image
                    Group{
                        if !isPhotoSelected { Image(systemName: "doc.fill.badge.plus").font(.system(size: AppSizes.s100)).onTapGesture {
                              isPhotoPickerPresented.toggle()
                              isPhotoSelected = true
                          }
                        }else{  Image(uiImage: image)
                              .resizable()
                             
                              .frame(width: UIScreen.main.bounds.width - AppSizes.s20, height: AppSizes.s200, alignment: .center)
                        }
                    }
                 //MARK: - Text Fields
                    RectangleTextFieldShape()
                        .overlay(TextField(AppStrings.name, text: $name).padding(.horizontal,AppSizes.s15))
                    RectangleTextFieldShape()
                        .overlay(TextField(AppStrings.category, text: $category).padding(.horizontal,AppSizes.s15))
                    RectangleTextFieldShape()
                        .overlay(TextField(AppStrings.price, text: $price).padding(.horizontal,AppSizes.s15))
                    RectangleTextFieldShape()
                        .overlay(TextField(AppStrings.quantity, text: $quantity).padding(.horizontal,AppSizes.s15))
                    RectangleTextFieldShape(height: AppSizes.s90)
                        .overlay(TextField(AppStrings.description, text: $description).padding(.horizontal,AppSizes.s15))
                    //MARK: - Save Button
                    Button(AppStrings.save){
                        showProgressView = true
                        AppConstants.apiManager.uploadImageToFireStorage(completion: { data, error in
                            if let error = error {
                                print(error)
                                showProgressView = false
                                responseMessage = error as! String
                                showErrorView = true
                            }else{
                                saveProduct(product: ProductModel(id: nil, name: name, category: category, imageUrl: data, price: price, quantity: Int(quantity), description : description ,sizes: nil, rate: nil))
                                showProgressView = false
                                responseMessage = AppStrings.productAddedSuccessfully
                                showSuccessView = true
                                clearUI()
                            }
                        } , imageCollectionName : AppStrings.products, image: image)
                  
                    }
                    .font(.system(size: AppSizes.s20,weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - AppSizes.s20, height: AppSizes.s60, alignment: .center)
                    .background(Color.black)
                    .cornerRadius(AppSizes.s10)

                    Spacer()
              
                }//:VSTACK
                .sheet(isPresented: $isPhotoPickerPresented){
                      ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
                }
                .navigationBarTitle(AppStrings.addProduct)
                .navigationBarTitleDisplayMode(.inline)
                
                if showProgressView {AlertView(alertState: .loading, showAlert: $showProgressView)}
                if showErrorView {AlertView(alertState: .error,message: responseMessage ,showAlert: $showErrorView)}
                if showSuccessView {AlertView(alertState: .success,message: responseMessage, showAlert: $showSuccessView)}
                

            }//:ZSTACK
            
        }//:NavigationView
        

    }
    
    //MARK: - FUNCTIONS
    func saveProduct(product : ProductModel){
        
        AppConstants.apiManager.addProduct(completion: { data, error in
            if error != nil {
                showAlert = true
                responseMessage = error as! String
            }
        }, product: product)
    }
    
    func clearUI(){
        isPhotoSelected = false
        name = ""
        category = ""
        price = ""
        quantity = ""
        description = ""
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
            .previewDevice("iPhone 12 Pro Max")
    }
}


