//
//  ApiManager.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 29/12/2023.
//

import FirebaseFirestore
import FirebaseStorage
import SwiftUI
class ApiManager {
    private let _db = Firestore.firestore()
    
//MARK: - ADD PRODUCT
    func addProduct(completion : @escaping(_ data : Any? ,_ error : Any?)-> Void , product : ProductModel){
        let productId = UUID().uuidString
        _db.collection(FirebaseCollectionReferences.Product.rawValue).document(productId).setData([
            "id" : productId,
            "name" : product.name ?? "",
            "category" : product.category ?? "",
            "image": product.imageUrl ?? "",
            "price" : product.price ?? "",
            "quantity" : product.quantity ?? 0,
//            "size" : product.sizes ?? [],
        ]){err in
            if err != nil {
                completion(nil , err?.localizedDescription)
            }
        }
        completion(AppStrings.success , nil)
    }
//MARK: - ADD CATEGORY
    func addCategory(completion : @escaping(_ data : Any? ,_ error : Any?)-> Void , category : CategoryModel){
        let categoryId = UUID().uuidString
        _db.collection(FirebaseCollectionReferences.Category.rawValue).document(categoryId).setData([
            "id" : categoryId,
            "name" : category.name ?? "",
            "imageUrl": category.imageUrl ?? "",

        ]){err in
            if err != nil {
                completion(nil , err?.localizedDescription)
            }
        }
        completion(AppStrings.success , nil)
    }
    //MARK: - ADD Coupon
        func addCoupon(completion : @escaping(_ data : Any? ,_ error : Any?)-> Void , coupon : CouponModel){
            let couponId = UUID().uuidString
            _db.collection(FirebaseCollectionReferences.Coupons.rawValue).document(couponId).setData([
                "id" : couponId,
                "code" : coupon.code ?? "",
                "discount": coupon.discount ?? "",

            ]){err in
                if err != nil {
                    completion(nil , err?.localizedDescription)
                }
            }
            completion(AppStrings.success , nil)
        }
    //MARK: - Get Orders
        func addCoupon(completion : @escaping(_ data : [OrderModel]? ,_ error : Any?)-> Void){
            _db.collection(FirebaseCollectionReferences.Orders.rawValue).do
        }
    //MARK: - ADD Coupon
        func addBanner(completion : @escaping(_ data : Any? ,_ error : Any?)-> Void , banner : BannerModel){
            let bannerId = UUID().uuidString
            _db.collection(FirebaseCollectionReferences.Banners.rawValue).document(bannerId).setData([
                "id" : bannerId,
                "imageUrl" : banner.imageUrl
            ]){err in
                if err != nil {
                    completion(nil , err?.localizedDescription)
                }
            }
            completion(AppStrings.success , nil)
        }
    //MARK: - Upload Image

    func uploadImageToFireStorage(completion :@escaping(_ data : String? , _ error : Any?) -> Void ,imageCollectionName : String,image : UIImage)  {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("\(imageCollectionName)/\(UUID().uuidString)")
        guard let imgData = image.jpegData(compressionQuality: 0.5) else {
            completion(nil,"NoData!")
            return
        }
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putData(imgData, metadata: nil) { (metadata, error) in
            completion(nil,error?.localizedDescription)
          // You can also access to download URL after upload.
          riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
                completion(nil,error?.localizedDescription)
              return
            }
             completion(downloadURL.absoluteString,nil)
          }
        }
    }
}
