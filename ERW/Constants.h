//
//  Constants.h
//  ERW
//
//  Created by nestcode on 3/30/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_ZOOMED (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

#define iPhoneVersion ([[UIScreen mainScreen] bounds].size.height == 568 ? 5 : ([[UIScreen mainScreen] bounds].size.height == 812 ? 10 : ([[UIScreen mainScreen] bounds].size.height == 667 ? 6 : ([[UIScreen mainScreen] bounds].size.height == 736 ? 61 : 999))))

#define spring_green @"58c7c9"
#define violet @"6d74fc"
#define bright_pink @"fa4678"
#define blueClr @"2B7FB6"
#define orangeClr @"E04334"
#define azure @"3697D7"
#define chartreuse @"84C25C"
#define greenClr @"10AFAA"
#define yellowClr @"f79b6a"
#define cyan @"F2707A"
#define redClr @"65dfdf"
#define magenta @"f981f9"
#define staticClr @"58c79f"
#define waveClr @"520089"
#define ThemeColor @"41426D"
//65,66,109

//Local : http://10.0.1.102:8000/
#define URL_BASE    @"http://10.0.1.102:8000/api/" //LIVE
#define URL_IMAGE    @"http://10.0.1.102:8000"   //LIVE


#define URL_LOGIN    URL_BASE@"login"
#define URL_LOGIN_X    URL_BASE@"loginWallet"
#define URL_REGISTER    URL_BASE@"register"
#define URL_GET_ACCOUNTS   URL_BASE"getAccounts"
#define URL_CREATE_ACCOUNTS   URL_BASE"createAccount"
#define URL_GET_TRANSACTIONS   URL_BASE"getTransactions"
#define URL_ACCOUNT_BALANCE    URL_BASE@"accountBalances"
#define URL_LOGOUT    URL_BASE@"revokeDevice"
#define URL_TOKENS    URL_BASE@"tokens"
#define URL_ACTIVITYLOG    URL_BASE@"activities"
#define URL_SEND_AMOUNT    URL_BASE@"sendAmount"
#define URL_UPDATE_PHONE    URL_BASE@"updatePhone"
#define URL_UPDATE_NOTIFICATION    URL_BASE@"updateNotification"
#define URL_UPDATE_EMAIL_VERIFICATION    URL_BASE@"updateEmailVerification"
#define URL_UPDATE_ACTIVITY    URL_BASE@"updateActivityLog"
#define URL_REFRESH_BALANCE    URL_BASE@"refreshBalance"
#define URL_CHANGE_PASSWORD    URL_BASE@"changePassword"
#define URL_2FA    URL_BASE@"2fa"
#define URL_EDIT_ACCOUNT    URL_BASE@"editAccount"
#define URL_SETTINGS    URL_BASE@"userSettings"
#define URL_DEVICETOKEN    URL_BASE@"deviceToken"
#define URL_VERIFY_EMAIL    URL_BASE@"verifyEmail"
#define URL_GENERATE_SEED   URL_BASE@"generateSeed"
#define URL_TRANSACTION_PASS   URL_BASE@"transaction-pass"
#define URL_WALLET_CURRENCIES   URL_BASE@"walletCurrency"
#define URL_STORE_SEEDS  URL_BASE@"storeSeed"
typedef enum
{
    CALL_TYPE_NONE,
    CALL_TYPE_LOGIN,
    CALL_TYPE_LOGIN_X,
    CALL_TYPE_REGISTER,
    CALL_TYPE_GET_ACCOUNTS,
    CALL_TYPE_CREATE_ACCOUNTS,
    CALL_TYPE_GET_TRANSACTIONS,
    CALL_TYPE_ACCOUNT_BALANCE,
    CALL_TYPE_LOGOUT,
    CALL_TYPE_TOKENS,
    CALL_TYPE_ACTIVITYLOG,
    CALL_TYPE_SEND_AMOUNT,
    CALL_TYPE_UPDATE_PHONE,
    CALL_TYPE_UPDATE_NOTIFICATION,
    CALL_TYPE_UPDATE_EMAIL_VERIFICATION,
    CALL_TYPE_UPDATE_ACTIVITY,
    CALL_TYPE_REFRESH_BALANCE,
    CALL_TYPE_CHANGE_PASSWORD,
    CALL_TYPE_2FA,
    CALL_TYPE_EDIT_ACCOUNT,
    CALL_TYPE_SETTINGS,
    CALL_TYPE_DEVICETOKEN,
    CALL_TYPE_VERIFY_EMAIL,
    CALL_TYPE_GENERATE_SEED,
    CALL_TYPE_TRANSACTION_PASS,
    CALL_TYPE_WALLET_CURRENCIES,
    CALL_TYPE_STORE_SEEDS,
}CallTypeEnum;



#endif /* Constants_h */
