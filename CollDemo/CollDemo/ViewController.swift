//
//  ViewController.swift
//  CollDemo
//
//  Created by Sarika on 26/07/22.
//

import UIKit
import Foundation
import CommonCrypto

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var coll_trailing_const: NSLayoutConstraint!
    @IBOutlet weak var coll_leading_const: NSLayoutConstraint!
    @IBOutlet weak var collBackView_height_const: NSLayoutConstraint!
    
    @IBOutlet weak var coll_cards: UICollectionView!
    
    var levelNumber = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        coll_leading_const.constant =  UIDevice.current.userInterfaceIdiom == .pad ? 100 : 15
        coll_trailing_const.constant =  UIDevice.current.userInterfaceIdiom == .pad ? 100 : 15
        coll_cards.layer.cornerRadius = 3
        setCollLayout()
        
    }
    
    func hashSHA256(data:Data) -> Data? {
        var hashData = Data(count: Int(CC_SHA1_DIGEST_LENGTH))
        _ = hashData.withUnsafeMutableBytes {digestBytes in
            data.withUnsafeBytes {messageBytes in
                CC_SHA1(messageBytes, CC_LONG(data.count), digestBytes)
            }
        }
        return hashData
    }
    
    func setCollLayout(){
        
        let layout = UICollectionViewFlowLayout()
        
        let width = coll_cards.frame.size.width
        
        print("Width::",width)
        
        let reduceSize = UIDevice.current.userInterfaceIdiom == .pad ? 0.015 : 0.015
        
        let space = (width * reduceSize)
        let squareSize = ((width / levelNumber)) - (space * 1.5)
        layout.itemSize = CGSize(width: squareSize, height: squareSize)
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space * 1.2
        coll_cards.collectionViewLayout = layout
        
        coll_cards.delegate = self
        coll_cards.dataSource = self
        
        coll_cards.reloadData()
        
        collBackView_height_const.constant = coll_cards.contentSize.height
        
    }
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Int(levelNumber * levelNumber)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath)
        cell.layer.cornerRadius = 3
        return cell
        
        
    }
 
    @IBAction func click_onTopButtons(_ sender: UIButton) {
        
        levelNumber = Double(sender.tag)
        setCollLayout()
    }
    
}

extension Data {

    /// Hashing algorithm that prepends an RSA2048ASN1Header to the beginning of the data being hashed.
    ///
    /// - Parameters:
    ///   - type: The type of hash algorithm to use for the hashing operation.
    ///   - output: The type of output string desired.
    /// - Returns: A hash string using the specified hashing algorithm, or nil.
    public func hashWithRSA2048Asn1Header(_ type: HashType, output: HashOutputType = .hex) -> String? {

        let rsa2048Asn1Header:[UInt8] = [
            0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
            0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
        ]

        var headerData = Data(rsa2048Asn1Header)
        headerData.append(self)

        return hashed(type, output: output)
    }

    /// Hashing algorithm for hashing a Data instance.
    ///
    /// - Parameters:
    ///   - type: The type of hash to use.
    ///   - output: The type of hash output desired, defaults to .hex.
    ///   - Returns: The requested hash output or nil if failure.
    public func hashed(_ type: HashType, output: HashOutputType = .hex) -> String? {

        // setup data variable to hold hashed value
        var digest = Data(count: Int(type.length))

        _ = digest.withUnsafeMutableBytes{ digestBytes -> UInt8 in
            self.withUnsafeBytes { messageBytes -> UInt8 in
                if let mb = messageBytes.baseAddress, let db = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let length = CC_LONG(self.count)
                    switch type {
                    case .md5: CC_MD5(mb, length, db)
                    case .sha1: CC_SHA1(mb, length, db)
                    case .sha224: CC_SHA224(mb, length, db)
                    case .sha256: CC_SHA256(mb, length, db)
                    case .sha384: CC_SHA384(mb, length, db)
                    case .sha512: CC_SHA512(mb, length, db)
                    }
                }
                return 0
            }
        }

        // return the value based on the specified output type.
        switch output {
        case .hex: return digest.map { String(format: "%02hhx", $0) }.joined()
        case .base64: return digest.base64EncodedString()
        }
    }
}

public enum HashOutputType {
    // standard hex string output
    case hex
    // base 64 encoded string output
    case base64
}

// Defines types of hash algorithms available
public enum HashType {
    case md5
    case sha1
    case sha224
    case sha256
    case sha384
    case sha512

    var length: Int32 {
        switch self {
        case .md5: return CC_MD5_DIGEST_LENGTH
        case .sha1: return CC_SHA1_DIGEST_LENGTH
        case .sha224: return CC_SHA224_DIGEST_LENGTH
        case .sha256: return CC_SHA256_DIGEST_LENGTH
        case .sha384: return CC_SHA384_DIGEST_LENGTH
        case .sha512: return CC_SHA512_DIGEST_LENGTH
        }
    }
}

public extension String {

    /// Hashing algorithm for hashing a string instance.
    ///
    /// - Parameters:
    ///   - type: The type of hash to use.
    ///   - output: The type of output desired, defaults to .hex.
    /// - Returns: The requested hash output or nil if failure.
    public func hashed(_ type: HashType, output: HashOutputType = .hex) -> String? {

        // convert string to utf8 encoded data
        guard let message = data(using: .utf8) else { return nil }
        return message.hashed(type, output: output)
    }
}
