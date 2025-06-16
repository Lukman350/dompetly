class BaseResponse<T> {
  final bool success;
  final T? data;
  final String? message;

  BaseResponse({required this.success, this.data, this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json['success'],
      data: json['data'],
      message: json['message'],
    );
  }
}
