import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  String paymentID;
  String methodID;
  bool success;
  StripeTransactionResponse({this.message,this.paymentID,this.methodID,this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret = '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';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(
        StripeOptions(
            publishableKey: "pk_live_51IwjdHSEJ2gvleU3x3V4sVQfkNDYPC4rpwPBFE4WTU7tig3KNCXEdZ2Y5efuA5DXN8WEdAxgTvh6UBHIxopJYIxZ00Iyvnov9o",
            merchantId: "Live",
            androidPayMode: 'live'
        )
    );
  }

  static Future<StripeTransactionResponse> payViaExistingCard({String amount, String currency, CreditCard card}) async{
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card)
      );
      var paymentIntent = await StripeService.createPaymentIntent(
          amount,
          currency
      );
      var response = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent['client_secret'],
              paymentMethodId: paymentMethod.id
          )
      );
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
            message: 'Transaction successful',
            paymentID: response.paymentIntentId.toString(),
            methodID: response.paymentMethodId.toString(),
            success: true,
        );
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed',
            paymentID: response.paymentIntentId.toString(),
            methodID: response.paymentMethodId.toString(),
            success: false
        );
      }
    } on PlatformException catch(err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}',
          paymentID: '',
          methodID: '',
          success: false
      );
    }
  }

  static Future<StripeTransactionResponse> payWithNewCard({String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest(),
      );
      var paymentIntent = await StripeService.createPaymentIntent(
          amount,
          currency
      );
      var response = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent['client_secret'],
              paymentMethodId: paymentMethod.id
          )
      );
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
          message: 'Transaction successful${response.toJson()}',
          paymentID: response.paymentIntentId.toString(),
          methodID: response.paymentMethodId.toString(),
          success: true,
        );
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed',
            success: false
        );
      }
    } on PlatformException catch(err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}',
          success: false
      );
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong ${err.toString()}';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(
        message: message,
        success: false
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(Uri.parse(StripeService.paymentApiUrl),
          body: body,
          headers: StripeService.headers
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }
}