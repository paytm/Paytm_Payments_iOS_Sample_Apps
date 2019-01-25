# PaytmNativeSDK

[![CI Status](https://img.shields.io/travis/Pawan Agarwal/PaytmNativeSDK.svg?style=flat)](https://travis-ci.org/Pawan Agarwal/PaytmNativeSDK)
[![Version](https://img.shields.io/cocoapods/v/PaytmNativeSDK.svg?style=flat)](https://cocoapods.org/pods/PaytmNativeSDK)
[![License](https://img.shields.io/cocoapods/l/PaytmNativeSDK.svg?style=flat)](https://cocoapods.org/pods/PaytmNativeSDK)
[![Platform](https://img.shields.io/cocoapods/p/PaytmNativeSDK.svg?style=flat)](https://cocoapods.org/pods/PaytmNativeSDK)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Swift 4.2 

## Installation

PaytmNativeSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PaytmNativeSDK'
```
## Integration Steps

**Step 1a:** Add the framework to your project using CocoaPods

**Step 2:** Add the framework to your project
Params: 

1) isAoA : Bool : Merchant is AOA merchant or not
2) cid : String : Your Customer Id.
3) token : String : Get this from Initiate transaction API call from merchant's end
4)  txnAmount: String =  Transaction Amount.
5) mid : String = YOUR MID

6) orderID: String =  Generated Order Id

7) String merchantName:  Merchant name
8) requestType : String = if AOA Merchant requestType = "UNI_PAY" else requestType = "Payment"
9) urlString  : String = " https://securegw.paytm.in/theia/paytmCallback?ORDER_ID="
Sample Body Param : 

**Step 3:** Configure the BodyParam as 

let bodyParams = ["head": ["channelId":"WAP","clientId":"C11","requestTimestamp":"Time","signature":"CH","version":"v1"],"body":["callbackUrl":urlString + "\(orderId)","mid":"\(merchantId)","orderId":"\(orderId)","requestType":requestType,"websiteName":"Retail","paytmSsoToken":"\(ssoToken)","txnAmount":["value":"\(txnAmount)","currency":"INR"],"userInfo":["custId":(cid)]]]

**Step 4:** Sample code for Invoking SDK :


let sdk = PaytmNativeSDK(txnToken: token, orderId: orderId, merchantId: self!.merchantId, isAuthenticated: isAuthenticated, amount: CGFloat(Double(txnAmount) ?? 1.0), callbackUrl: urlString +"\(orderId)", andDelegate: self!, isAOA: self!.isAOA)

*Step 5** Add  following in your Run Script:
bash ./{Path}/PaytmNativeSDK.framework/strip-frameworks.sh


## Author

Pawan Agarwal, pawan.agarwal@paytm.com

## License

PaytmNativeSDK is available under the MIT license. See the LICENSE file for more info.
