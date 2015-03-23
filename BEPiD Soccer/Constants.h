//
//  Constants.h
//  Aproximar
//
//  Created by Enrique C. Melgarejo on 14/09/14.
//  Copyright (c) 2014 GreenB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#pragma mark - defines

#define is_iPhone UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
#define is_iPad UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#pragma mark - general

static BOOL debugMode = TRUE;
static NSString *projectName = @"Aproximar";

//static NSString *serverUrl = @"http://aproximar.greenb.com.br";
static NSString *serverUrl = @"http://beta.aproximar.greenb.com.br";
//static NSString *serverUrl = @"http://172.16.2.0:8081"; //testes locais
//static NSString *serverUrl = @"http://192.168.0.109:8081"; //testes locais
static NSInteger timeoutInterval = 15;

#pragma mark - placeholders

static NSString *PASSWORD_MASK = @"********";
static NSString *IMAGE_DEFAULT_STUDENT = @"perfil-photo.png";

#pragma mark - endPoints

static NSString *endPointLogin = @"/api/login";
static NSString *endPointStudent = @"/api/student";
static NSString *endPointResponsible = @"/api/responsible";
static NSString *endPointInterested = @"/api/interested";
static NSString *endPointEducator = @"/api/educator";
static NSString *endPointAdministrator = @"/api/administrator";
static NSString *endPointInstitution = @"/api/institution";
static NSString *endPointMedia = @"/api/media";
static NSString *endPointMediaList = @"/api/medialist";
static NSString *endPointRegisterPush = @"/api/push";
static NSString *endPointFacebook = @"/api/facebook";
static NSString *endPointBindRequest = @"/api/binding";
static NSString *endPointBindRequestList = @"/api/requests";

#pragma mark - communication errors

static NSString *INVALID_JSON_FORMAT = @"JSON com formato inválido.";
static NSString *COULD_NOT_CONNECT = @"Não foi possível conectar-se com o servidor.";
static NSString *UNEXPECTED_SERVER_ERROR = @"Erro de comunicação com o servidor.";
static NSString *UNEXPECTED_INTERNAL_ERROR = @"Erro interno. Tente novamente em instantes.";
static NSString *NO_VALUE_RECEIVED = @"Sem valor recebido.";
static NSString *INVALID_TOKEN = @"Token inválido.";
static NSString *INVALID_USER_PASSWORD = @"Usuário ou senha inválida.";
static NSString *DISCONNECTED = @"Desconectado.";
static NSString *NO_NETWORK = @"Você está sem conexão com a internet.";
static NSString *INVALID_FACEBOOK_SESSION = @"Não foi possível validar a sessão com o Facebook. Tente novamente em instantes.";
static NSString *INVALID_SESSION_RECONNECTING = @"Sessão inválida. Reconectando...";

#pragma mark - local errors

static NSString *DEFAULT_ERROR_TITLE = @"Oops! =(";
static NSString *DEFAULT_SUCCESS_TITLE = @"Sucesso";
static NSString *DEFAULT_INFO_TITLE = @"Aviso";
static NSString *DEFAULT_NOTIFICATION_TITLE = @"Nova Notificação";

#pragma mark - userDefaults temporary keys (erased when log out)
static NSString *keyIsLogged = @"isLogged";
static NSString *keyIsFirstLogin = @"isFirstLogin";
static NSString *keyNotificationStatus = @"isNotifying";
static NSString *keyNewAccType = @"newAccountType";
static NSString *keyAdmDic = @"admDictionary";
static NSString *keyStudentId = @"selectedStudentId";
static NSString *keyBadgeToBindRequestsThatIMade = @"bindRequestsThatIMadeCount";
static NSString *keyBadgeToBindRequestsToApprove = @"bindRequestsToApproveCount";

#pragma mark - userDefaults FIXED keys
static NSString *keyToken = @"token";
static NSString *keyIsLoginPersistent = @"isLoginPersistent";
static NSString *keyTokenForPushNotification = @"tokenForPushNotification";
static NSString *keyUserIdForPushNotification = @"userIdForPushNotification";

#pragma mark - video settings

static CGFloat maximumVideoLength = 15.0f;

#pragma mark - communication atatus

enum JsonErrorCode
{
    Success = 0,
    Fail = 1,
    InvalidToken = 2,
    Disconnected = 3,
    Nolicense = 4,
    Unauthorized = 5,
    NotFound = 6,
    UnsupportedClient = 7,
    ServerInternalError = 8,
    InvalidLogin = 9,
    FacebookWithoutAccount = 10,
    NoNetwork = 19,
    NoResponse = 20
};

typedef enum {
    Http_Continue = 100,
    Http_SwitchingProtocols = 101,
    Http_OK = 200,
    Http_Created = 201,
    Http_Accepted = 202,
    Http_NonAuthoritativeInformation = 203,
    Http_NoContent = 204,
    Http_ResetContent = 205,
    Http_PartialContent = 206,
    Http_MultipleChoices = 300,
    Http_Ambiguous = 300,
    Http_MovedPermanently = 301,
    Http_Moved = 301,
    Http_Found = 302,
    Http_Redirect = 302,
    Http_SeeOther = 303,
    Http_RedirectMethod = 303,
    Http_NotModified = 304,
    Http_UseProxy = 305,
    Http_Unused = 306,
    Http_TemporaryRedirect = 307,
    Http_RedirectKeepVerb = 307,
    Http_BadRequest = 400,
    Http_Unauthorized = 401,
    Http_PaymentRequired = 402,
    Http_Forbidden = 403,
    Http_NotFound = 404,
    Http_MethodNotAllowed = 405,
    Http_NotAcceptable = 406,
    Http_ProxyAuthenticationRequired = 407,
    Http_RequestTimeout = 408,
    Http_Conflict = 409,
    Http_Gone = 410,
    Http_LengthRequired = 411,
    Http_PreconditionFailed = 412,
    Http_RequestEntityTooLarge = 413,
    Http_RequestUriTooLong = 414,
    Http_UnsupportedMediaType = 415,
    Http_RequestedRangeNotSatisfiable = 416,
    Http_ExpectationFailed = 417,
    Http_InternalServerError = 500,
    Http_NotImplemented = 501,
    Http_BadGateway = 502,
    Http_ServiceUnavailable = 503,
    Http_GatewayTimeout = 504,
    Http_HttpVersionNotSupported = 505
} HttpStatusCode;

#pragma mark - fixed tags
enum fixedTags
{
    tagToBackgroundPlaceholder = 900
};

#pragma mark - other constants

enum userTypes
{
    accTypeStudent = 1,
    accTypeParent = 2,
    accTypeInterested = 3,
    accTypeEducator = 4,
    accTypeAdministrator = 5,
    accTypeInstitution = 6
};

//used at Upload Queue
enum requestType
{
    requestTypeMedia = 1,
    requestTypeDiary = 2,
    requestTypeEvent = 3
};

enum mediaTypes
{
    mediaTypeImage = 1,
    mediaTypeVideo = 2,
    mediaTypeAudio = 3
};

//used in customizable titles
enum titleSizes
{
    smallTitle = 24,
    regularTitle = 30,
    largeTitle = 46
};

//used when linking users with a hash
enum linkTypes
{
    linkTypeInterested = 3,
    linkTypeParent = 2
};

enum bindRequestStatus
{
    bindRequestWaiting = 1,
    bindRequestAccepted = 2,
    bindRequestRejected = 3,
    bindRequestCanceled = 4
};

enum bindRequestType
{
    bindAsInterested = 1,
    bindAsResponsible = 2
};

enum statusPushNotification
{
    statusPushNotificationDisableByUser = 0,
    statusPushNotificationIsEnable = 1,
    statusPushNotificationDisableByError = 2
};
