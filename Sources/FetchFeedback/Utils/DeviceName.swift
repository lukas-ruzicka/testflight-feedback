enum DeviceName: String {

    case iPhone1_1
    case iPhone1_2
    case iPhone2_1
    case iPhone3_1
    case iPhone3_2
    case iPhone3_3
    case iPhone4_1
    case iPhone5_1
    case iPhone5_2
    case iPhone5_3
    case iPhone5_4
    case iPhone6_1
    case iPhone6_2
    case iPhone7_1
    case iPhone7_2
    case iPhone8_1
    case iPhone8_2
    case iPhone8_4
    case iPhone9_1
    case iPhone9_2
    case iPhone9_3
    case iPhone9_4
    case iPhone10_1
    case iPhone10_2
    case iPhone10_3
    case iPhone10_4
    case iPhone10_5
    case iPhone10_6
    case iPhone11_2
    case iPhone11_4
    case iPhone11_6
    case iPhone11_8
    case iPhone12_1
    case iPhone12_3
    case iPhone12_5
    case iPhone12_8
    case iPhone13_1
    case iPhone13_2
    case iPhone13_3
    case iPhone13_4
    case iPhone14_2
    case iPhone14_3
    case iPhone14_4
    case iPhone14_5
    case iPhone14_6

    case iPod1_1
    case iPod2_1
    case iPod3_1
    case iPod4_1
    case iPod5_1
    case iPod7_1
    case iPod9_1

    case iPad1_1
    case iPad1_2
    case iPad2_1
    case iPad2_2
    case iPad2_3
    case iPad2_4
    case iPad3_1
    case iPad3_2
    case iPad3_3
    case iPad2_5
    case iPad2_6
    case iPad2_7
    case iPad3_4
    case iPad3_5
    case iPad3_6
    case iPad4_1
    case iPad4_2
    case iPad4_3
    case iPad4_4
    case iPad4_5
    case iPad4_6
    case iPad4_7
    case iPad4_8
    case iPad4_9
    case iPad5_1
    case iPad5_2
    case iPad5_3
    case iPad5_4
    case iPad6_3
    case iPad6_4
    case iPad6_7
    case iPad6_8
    case iPad6_11
    case iPad6_12
    case iPad7_1
    case iPad7_2
    case iPad7_3
    case iPad7_4
    case iPad7_5
    case iPad7_6
    case iPad7_11
    case iPad7_12
    case iPad8_1
    case iPad8_2
    case iPad8_3
    case iPad8_4
    case iPad8_5
    case iPad8_6
    case iPad8_7
    case iPad8_8
    case iPad8_9
    case iPad8_10
    case iPad8_11
    case iPad8_12
    case iPad11_1
    case iPad11_2
    case iPad11_3
    case iPad11_4
    case iPad11_6
    case iPad11_7
    case iPad12_1
    case iPad12_2
    case iPad14_1
    case iPad14_2
    case iPad13_1
    case iPad13_2
    case iPad13_4
    case iPad13_5
    case iPad13_6
    case iPad13_7
    case iPad13_8
    case iPad13_9
    case iPad13_10
    case iPad13_11
    case iPad13_16
    case iPad13_17

    var name: String {
        switch self {
        case .iPhone1_1:
            return "iPhone"
        case .iPhone1_2:
            return "iPhone 3G"
        case .iPhone2_1:
            return "iPhone 3GS"
        case .iPhone3_1:
            return "iPhone 4"
        case .iPhone3_2:
            return "iPhone 4 GSM Rev A"
        case .iPhone3_3:
            return "iPhone 4 CDMA"
        case .iPhone4_1:
            return "iPhone 4S"
        case .iPhone5_1:
            return "iPhone 5 (GSM)"
        case .iPhone5_2:
            return "iPhone 5 (GSM+CDMA)"
        case .iPhone5_3:
            return "iPhone 5C (GSM)"
        case .iPhone5_4:
            return "iPhone 5C (Global)"
        case .iPhone6_1:
            return "iPhone 5S (GSM)"
        case .iPhone6_2:
            return "iPhone 5S (Global)"
        case .iPhone7_1:
            return "iPhone 6 Plus"
        case .iPhone7_2:
            return "iPhone 6"
        case .iPhone8_1:
            return "iPhone 6s"
        case .iPhone8_2:
            return "iPhone 6s Plus"
        case .iPhone8_4:
            return "iPhone SE (GSM)"
        case .iPhone9_1:
            return "iPhone 7"
        case .iPhone9_2:
            return "iPhone 7 Plus"
        case .iPhone9_3:
            return "iPhone 7"
        case .iPhone9_4:
            return "iPhone 7 Plus"
        case .iPhone10_1:
            return "iPhone 8"
        case .iPhone10_2:
            return "iPhone 8 Plus"
        case .iPhone10_3:
            return "iPhone X Global"
        case .iPhone10_4:
            return "iPhone 8"
        case .iPhone10_5:
            return "iPhone 8 Plus"
        case .iPhone10_6:
            return "iPhone X GSM"
        case .iPhone11_2:
            return "iPhone XS"
        case .iPhone11_4:
            return "iPhone XS Max"
        case .iPhone11_6:
            return "iPhone XS Max Global"
        case .iPhone11_8:
            return "iPhone XR"
        case .iPhone12_1:
            return "iPhone 11"
        case .iPhone12_3:
            return "iPhone 11 Pro"
        case .iPhone12_5:
            return "iPhone 11 Pro Max"
        case .iPhone12_8:
            return "iPhone SE 2nd Gen"
        case .iPhone13_1:
            return "iPhone 12 Mini"
        case .iPhone13_2:
            return "iPhone 12"
        case .iPhone13_3:
            return "iPhone 12 Pro"
        case .iPhone13_4:
            return "iPhone 12 Pro Max"
        case .iPhone14_2:
            return "iPhone 13 Pro"
        case .iPhone14_3:
            return "iPhone 13 Pro Max"
        case .iPhone14_4:
            return "iPhone 13 Mini"
        case .iPhone14_5:
            return "iPhone 13"
        case .iPhone14_6:
            return "iPhone SE 3rd Gen"
        case .iPod1_1:
            return "1st Gen iPod"
        case .iPod2_1:
            return "2nd Gen iPod"
        case .iPod3_1:
            return "3rd Gen iPod"
        case .iPod4_1:
            return "4th Gen iPod"
        case .iPod5_1:
            return "5th Gen iPod"
        case .iPod7_1:
            return "6th Gen iPod"
        case .iPod9_1:
            return "7th Gen iPod"
        case .iPad1_1:
            return "iPad"
        case .iPad1_2:
            return "iPad 3G"
        case .iPad2_1:
            return "2nd Gen iPad"
        case .iPad2_2:
            return "2nd Gen iPad GSM"
        case .iPad2_3:
            return "2nd Gen iPad CDMA"
        case .iPad2_4:
            return "2nd Gen iPad New Revision"
        case .iPad3_1:
            return "3rd Gen iPad"
        case .iPad3_2:
            return "3rd Gen iPad CDMA"
        case .iPad3_3:
            return "3rd Gen iPad GSM"
        case .iPad2_5:
            return "iPad mini"
        case .iPad2_6:
            return "iPad mini GSM+LTE"
        case .iPad2_7:
            return "iPad mini CDMA+LTE"
        case .iPad3_4:
            return "4th Gen iPad"
        case .iPad3_5:
            return "4th Gen iPad GSM+LTE"
        case .iPad3_6:
            return "4th Gen iPad CDMA+LTE"
        case .iPad4_1:
            return "iPad Air (WiFi)"
        case .iPad4_2:
            return "iPad Air (GSM+CDMA)"
        case .iPad4_3:
            return "1st Gen iPad Air (China)"
        case .iPad4_4:
            return "iPad mini Retina (WiFi)"
        case .iPad4_5:
            return "iPad mini Retina (GSM+CDMA)"
        case .iPad4_6:
            return "iPad mini Retina (China)"
        case .iPad4_7:
            return "iPad mini 3 (WiFi)"
        case .iPad4_8:
            return "iPad mini 3 (GSM+CDMA)"
        case .iPad4_9:
            return "iPad Mini 3 (China)"
        case .iPad5_1:
            return "iPad mini 4 (WiFi)"
        case .iPad5_2:
            return "4th Gen iPad mini (WiFi+Cellular)"
        case .iPad5_3:
            return "iPad Air 2 (WiFi)"
        case .iPad5_4:
            return "iPad Air 2 (Cellular)"
        case .iPad6_3:
            return "iPad Pro (9.7 inch, WiFi)"
        case .iPad6_4:
            return "iPad Pro (9.7 inch, WiFi+LTE)"
        case .iPad6_7:
            return "iPad Pro (12.9 inch, WiFi)"
        case .iPad6_8:
            return "iPad Pro (12.9 inch, WiFi+LTE)"
        case .iPad6_11:
            return "iPad (2017)"
        case .iPad6_12:
            return "iPad (2017)"
        case .iPad7_1:
            return "iPad Pro 2nd Gen (WiFi)"
        case .iPad7_2:
            return "iPad Pro 2nd Gen (WiFi+Cellular)"
        case .iPad7_3:
            return "iPad Pro 10.5-inch 2nd Gen"
        case .iPad7_4:
            return "iPad Pro 10.5-inch 2nd Gen"
        case .iPad7_5:
            return "iPad 6th Gen (WiFi)"
        case .iPad7_6:
            return "iPad 6th Gen (WiFi+Cellular)"
        case .iPad7_11:
            return "iPad 7th Gen 10.2-inch (WiFi)"
        case .iPad7_12:
            return "iPad 7th Gen 10.2-inch (WiFi+Cellular)"
        case .iPad8_1:
            return "iPad Pro 11 inch 3rd Gen (WiFi)"
        case .iPad8_2:
            return "iPad Pro 11 inch 3rd Gen (1TB, WiFi)"
        case .iPad8_3:
            return "iPad Pro 11 inch 3rd Gen (WiFi+Cellular)"
        case .iPad8_4:
            return "iPad Pro 11 inch 3rd Gen (1TB, WiFi+Cellular)"
        case .iPad8_5:
            return "iPad Pro 12.9 inch 3rd Gen (WiFi)"
        case .iPad8_6:
            return "iPad Pro 12.9 inch 3rd Gen (1TB, WiFi)"
        case .iPad8_7:
            return "iPad Pro 12.9 inch 3rd Gen (WiFi+Cellular)"
        case .iPad8_8:
            return "iPad Pro 12.9 inch 3rd Gen (1TB, WiFi+Cellular)"
        case .iPad8_9:
            return "iPad Pro 11 inch 4th Gen (WiFi)"
        case .iPad8_10:
            return "iPad Pro 11 inch 4th Gen (WiFi+Cellular)"
        case .iPad8_11:
            return "iPad Pro 12.9 inch 4th Gen (WiFi)"
        case .iPad8_12:
            return "iPad Pro 12.9 inch 4th Gen (WiFi+Cellular)"
        case .iPad11_1:
            return "iPad mini 5th Gen (WiFi)"
        case .iPad11_2:
            return "iPad mini 5th Gen"
        case .iPad11_3:
            return "iPad Air 3rd Gen (WiFi)"
        case .iPad11_4:
            return "iPad Air 3rd Gen"
        case .iPad11_6:
            return "iPad 8th Gen (WiFi)"
        case .iPad11_7:
            return "iPad 8th Gen (WiFi+Cellular)"
        case .iPad12_1:
            return "iPad 9th Gen (WiFi)"
        case .iPad12_2:
            return "iPad 9th Gen (WiFi+Cellular)"
        case .iPad14_1:
            return "iPad mini 6th Gen (WiFi)"
        case .iPad14_2:
            return "iPad mini 6th Gen (WiFi+Cellular)"
        case .iPad13_1:
            return "iPad Air 4th Gen (WiFi)"
        case .iPad13_2:
            return "iPad Air 4th Gen (WiFi+Cellular)"
        case .iPad13_4:
            return "iPad Pro 11 inch 5th Gen"
        case .iPad13_5:
            return "iPad Pro 11 inch 5th Gen"
        case .iPad13_6:
            return "iPad Pro 11 inch 5th Gen"
        case .iPad13_7:
            return "iPad Pro 11 inch 5th Gen"
        case .iPad13_8:
            return "iPad Pro 12.9 inch 5th Gen"
        case .iPad13_9:
            return "iPad Pro 12.9 inch 5th Gen"
        case .iPad13_10:
            return "iPad Pro 12.9 inch 5th Gen"
        case .iPad13_11:
            return "iPad Pro 12.9 inch 5th Gen"
        case .iPad13_16:
            return "iPad Air 5th Gen (WiFi)"
        case .iPad13_17:
            return "iPad Air 5th Gen (WiFi+Cellular)"
        }
    }
}
