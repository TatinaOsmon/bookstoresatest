import 'dart:convert';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class BookCategoryFindAllCall {
  static Future<ApiCallResponse> call({
    int? userId,
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'bookCategory findAll',
      apiUrl: 'https://ebookapi.shingonzo.com/bookCategory/findAll',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic bookCategory(dynamic response) => getJsonField(
        response,
        r'''$.bookCategory''',
        true,
      );

  static dynamic isPurchased(dynamic response) => getJsonField(
        response,
        r'''$.bookCategory[:].purchased''',
        true,
      );
}

class ToolCategoryFindAllCall {
  static Future<ApiCallResponse> call({
    int? userId,
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'toolCategory findAll ',
      apiUrl: 'https://ebookapi.shingonzo.com/toolCategory/findAll',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic toolCategory(dynamic response) => getJsonField(
        response,
        r'''$.toolCategory''',
        true,
      );
}

class MpThreeFindAllCategoriesCall {
  // ... other properties and methods of ApiCallResponse

  static Future<ApiCallResponse> call({int? userId}) async {
    // Define the request body as a JSON string
    final ffApiRequestBody = '''
{
  "userId": $userId
}''';

    // Use the ApiManager to make the API call
    return ApiManager.instance.makeApiCall(
      callName: 'mpThreeCategory findAll',
      apiUrl:
          'https://ebookapi.shingonzo.com/mp3Category/findAll', // Fixed typo in URL
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'JSESSIONID=1FAECAF659B98EEEFB1002019CB7B0FF'
      },
      params: {}, // Empty parameters
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic mp3(dynamic response) => getJsonField(
        response,
        r'''$.mp3Category''',
        true,
      );
}

class MpThreeFindAllCall {
  static Future<ApiCallResponse> call({
    int? id,
    int? userId,
    String? jwtToken,
    String? refreshToken,
  }) async {
    final ffApiRequestBody = jsonEncode({'id': id, 'userId': userId});
    print("userId: $userId");

    return ApiManager.instance.makeApiCall(
      callName: 'mpThree findAll',
      apiUrl: 'https://ebookapi.shingonzo.com/mp3/findAll',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic mp3(dynamic response) => getJsonField(
        response,
        r'''$.mp3''',
        true,
      );
}

class MpFourFindAllCategoriesCall {
  // ... other properties and methods of ApiCallResponse

  static Future<ApiCallResponse> call({int? userId, required id}) async {
    // Define the request body as a JSON string
    final ffApiRequestBody = '''
{
  "userId": $userId
}''';

    // Use the ApiManager to make the API call
    return ApiManager.instance.makeApiCall(
      callName: 'mpFourCategory findAll',
      apiUrl:
          'https://ebookapi.shingonzo.com/mp4Category/findAll', // Fixed typo in URL
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'JSESSIONID=712A9F96A04217F7D780C8DBA9EA2F2B'
      },
      params: {}, // Empty parameters
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic mp4(dynamic response) => getJsonField(
        response,
        r'''$.mp4Category''',
        true,
      );
}

class MpFourFindAllCall {
  static Future<ApiCallResponse> call({
    int? id,
    int? userId,
  }) async {
    final ffApiRequestBody = jsonEncode({'id': id, 'userId': userId});
    print("userId: $userId");
    print("id: $id");

    return ApiManager.instance.makeApiCall(
      callName: 'mpFour findAll',
      apiUrl: 'https://ebookapi.shingonzo.com/mp4/findAll',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic mp4(dynamic response) => getJsonField(
        response,
        r'''$.mp4''',
        true,
      );
}

class BookCartAddItemCall {
  static Future<ApiCallResponse> call({
    int? userId,
    int? productId,
    String? tableName = '',
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "productId": $productId,
  "tableName": "$tableName",
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'bookCart addItem',
      apiUrl: 'https://ebookapi.shingonzo.com/bookcart/addItem',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class BookCartCreateOrderCall {
  static Future<ApiCallResponse> call({
    int? userId,
    List<int>? indexList,
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final index = _serializeList(indexList);

    final ffApiRequestBody = '''
{
  "userId": $userId,
  "index": $index,
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'bookCart createOrder',
      apiUrl: 'https://ebookapi.shingonzo.com/bookcart/createOrder',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class ToolCartCreateOrderCall {
  static Future<ApiCallResponse> call({
    int? userId,
    List<int>? indexList,
    String? refreshToken = '',
    String? jwtToken = '',
  }) async {
    final index = _serializeList(indexList);

    final ffApiRequestBody = '''
{
  "userId": $userId,
  "index": $index,
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'toolCart createOrder',
      apiUrl: 'https://ebookapi.shingonzo.com/toolCart/createOrder',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class MediaCartCreateOrderCall {
  static Future<ApiCallResponse> call({
    int? userId,
    List<int>? indexList,
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final index = _serializeList(indexList);

    final ffApiRequestBody = '''
{
  "userId": $userId,
  "index": $index,
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'mediaCart createOrder',
      apiUrl: 'https://ebookapi.shingonzo.com/mediaCart/createOrder',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class ToolCartAddItemCall {
  static Future<ApiCallResponse> call({
    int? userId,
    int? productId,
    String? tableName = '',
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "productId": $productId,
  "tableName": "$tableName",
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'toolCart addItem',
      apiUrl: 'https://ebookapi.shingonzo.com/toolCart/addItem',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class MediaCartAddItemCall {
  static Future<ApiCallResponse> call({
    int? userId,
    int? productId,
    String? tableName = '',
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "productId": $productId,
  "tableName": "$tableName",
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'mediaCart addItem',
      apiUrl: 'https://ebookapi.shingonzo.com/mediaCart/addItem',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class BookFindAllCall {
  static Future<ApiCallResponse> call({
    int? userId,
    int? id,
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "id": $id
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'book findAll',
      apiUrl: 'https://ebookapi.shingonzo.com/book/findAll',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic book(dynamic response) => getJsonField(
        response,
        r'''$.books''',
        true,
      );
}

class ToolFindAllCall {
  static Future<ApiCallResponse> call({
    int? userId,
    int? id,
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "id": $id
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'tool findAll ',
      apiUrl: 'https://ebookapi.shingonzo.com/tool/findAll',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic tool(dynamic response) => getJsonField(
        response,
        r'''$.tools''',
        true,
      );
}

class BookCartFindAllCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'bookCart findAll',
      apiUrl: 'https://ebookapi.shingonzo.com/bookcart/findAll',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic bookcart(dynamic response) => getJsonField(
        response,
        r'''$.Bookcart''',
        true,
      );

  static dynamic price(dynamic response) => getJsonField(
        response,
        r'''$.Bookcart[:].price''',
        true,
      );

  static dynamic index(dynamic response) => getJsonField(
        response,
        r'''$.Bookcart[:].index''',
        true,
      );
}

class ToolCartFindAllCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'toolCart findAll',
      apiUrl: 'https://ebookapi.shingonzo.com/toolCart/findAll',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

//this is the code to get the data from the backend
  static dynamic toolCart(dynamic response) => getJsonField(
        response,
        r'''$.ToolCart''',
        true,
      );

  static dynamic price(dynamic response) => getJsonField(
        response,
        r'''$.ToolCart[:].price''',
        true,
      );

  static dynamic index(dynamic response) => getJsonField(
        response,
        r'''$.ToolCart[:].index''',
        true,
      );
}

class MediaCartFindAllCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'mediaCart findAll',
      apiUrl: 'https://ebookapi.shingonzo.com/mediaCart/findAll',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic priceList(dynamic response) => getJsonField(
        response,
        r'''$.MediaCart[:].price''',
        true,
      );

  static dynamic cartIndex(dynamic response) => getJsonField(
        response,
        r'''$.MediaCart[:].index''',
        true,
      );

  static dynamic mediaCart(dynamic response) => getJsonField(
        response,
        r'''$.MediaCart''',
        true,
      );
}

class BookCartRemoveItemCall {
  static Future<ApiCallResponse> call({
    int? userId,
    int? index,
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "index": $index,
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'bookCart removeItem',
      apiUrl: 'https://ebookapi.shingonzo.com/bookcart/removeItem',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class ToolCartRemoveItemCall {
  static Future<ApiCallResponse> call({
    int? userId,
    int? index,
    String? refreshToken = '',
    String? jwtToken = '',
    // required String toolId,
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "index": $index,
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'toolCart removeItem',
      apiUrl: 'https://ebookapi.shingonzo.com/toolCart/removeItem',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class MediaCartRemoveItemCall {
  static Future<ApiCallResponse> call({
    int? userId,
    int? index,
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "index": $index,
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'mediaCart removeItem',
      apiUrl: 'https://ebookapi.shingonzo.com/mediaCart/removeItem',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class PraySubmitFormCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? name = '',
    String? target = '',
    String? birthday = '',
    String? address = '',
    String? options = '',
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    Map<String, dynamic> requestBody = {
      "userId": userId,
      "name": name,
      "target": target,
      "birthday": birthday,
      "address": address,
      "options": options ?? '息災：滅除罪業、除去災害',
      "jwtToken": jwtToken,
      "refreshToken": refreshToken,
    };

    final ffApiRequestBody = '''
${json.encode(requestBody)}
''';
    return ApiManager.instance.makeApiCall(
      callName: 'pray submitForm',
      apiUrl: 'https://ebookapi.shingonzo.com/pray/submitForm',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class UserSignUpCall {
  static Future<ApiCallResponse> call({
    String? account = '',
    String? password = '',
    String? username = '',
    String? birthday = '',
    String? address = '',
    String? normal = '',
    String? guanding = '',
  }) async {
    final ffApiRequestBody = '''
{
  
  "account": "$account",
  "password": "$password",
  "username": "$username",
  "birthday": "$birthday",
  "address": "$address",
  "normal": "$normal",
  "guanding": "$guanding"
}''';
    print('666:$ffApiRequestBody');
    print('666birthday:$birthday');
    return ApiManager.instance.makeApiCall(
      callName: 'UserSignUp',
      apiUrl: 'https://ebookapi.shingonzo.com/appUser/signup',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class UserLoginCall {
  static Future<ApiCallResponse> call({
    String? account = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
  "account": "$account",
  "password": "$password"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UserLogin',
      apiUrl: 'https://ebookapi.shingonzo.com/appUser/login',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );

  static dynamic userId(dynamic response) => getJsonField(
        response,
        r'''$.userId''',
      );

  static dynamic jwtToken(dynamic response) => getJsonField(
        response,
        r'''$.jwtToken''',
      );

  static dynamic refreshToken(dynamic response) => getJsonField(
        response,
        r'''$.refreshToken''',
      );

  static dynamic success(dynamic response) => getJsonField(
        response,
        r'''$.success''',
      );
}

class PrayOrderDetailCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": ${userId},
  "jwtToken": "${jwtToken}",
  "refreshToken": "${refreshToken}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'prayOrderDetail',
      apiUrl: 'https://ebookapi.shingonzo.com/order/getPrayOrderDetail',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic prayOrderDetail(dynamic response) => getJsonField(
        response,
        r'''$.PrayOrderDetail''',
        true,
      );
  static dynamic jwtToken(dynamic response) => getJsonField(
        response,
        r'''$.jwtToken''',
      );
}

class GetOrderCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';

    print('userId:$userId');
    print('jwToken:$jwtToken');
    print('refreshToken:$refreshToken');
    return ApiManager.instance.makeApiCall(
      callName: 'getOrder',
      apiUrl: 'https://ebookapi.shingonzo.com/order/getOrder',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic order(dynamic response) => getJsonField(
        response,
        r'''$.order''',
        true,
      );

  static dynamic jwtToken(dynamic response) => getJsonField(
        response,
        r'''$.jwtToken''',
      );
}

class GetPaidObjectCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? jwtToken = '',
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userId,
  "jwtToken": "$jwtToken",
  "refreshToken": "$refreshToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getPaidObject',
      apiUrl: 'https://ebookapi.shingonzo.com/paidObject/getPaidObject',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic paidObject(dynamic response) => getJsonField(
        response,
        r'''$.paidObject''',
        true,
      );
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
