
#ifndef XSPhoneDefine_h
#define XSPhoneDefine_h

#define IOS_CELLULAR    @"pdp_ip0" // 蜂窝移动网络
#define IOS_WIFI        @"en0"     // WiFi
#define IOS_VPN         @"utun0"   // VPN
#define IP_ADDR_IPv4    @"ipv4"    // ipv4
#define IP_ADDR_IPv6    @"ipv6"    // ipv6

// 设备类型
typedef NS_ENUM(NSInteger, XSDeviceType) {
    XSDeviceTypeUnkown,         //未知类型
    XSDeviceTypeIPhone,         //iPhone
    XSDeviceTypeIPad,           //iPad
    XSDeviceTypeIPod,           //iPod
    XSDeviceTypeIPhoneSimulator,//手机模拟器
    XSDeviceTypeIPadSimulator   //iPad模拟器
};

// 设备 CPU 类型
typedef NS_ENUM(NSInteger, XSCPUType) {
    XSCPUTypeUnkown,    //未知类型
    XSCPUTypeARM,       //32位手机 CPU
    XSCPUTypeARM64,     //64位手机 CPU
    XSCPUTypeX86,       //32位电脑 CPU
    XSCPUTypeX86_64     //64位电脑 CPU
};



#endif /* XSPhoneDefine_h */
