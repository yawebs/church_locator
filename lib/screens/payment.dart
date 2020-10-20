// RaisedButton(

//                   child: Column(

//                     children: <Widget>[

//                       RaisedButton(

//                         child: Text("Pagar"),

//                         onPressed: () {



//                           _stripe_payment(state, context);



//                         },

//                       ),



//                     ],

//                   ),



//                 ),









// void _stripe_payment(state, BuildContext contextM ) async{



//   await StripePayment.paymentRequestWithCardForm(



//     CardFormPaymentRequest(),



//   ).then(



//           (PaymentMethod paymentMethod) async {



//         String _monto = calculateTotalPrice(state.cartProducts);

//         double _mon_do = double.parse(_monto) * 100;

//         int _redondeo = _mon_do.round();







//         final response = await http.post('https://limbototal.com/AndroidApp/Stripe/createIntent.php?ammountToPay=$_redondeo'   );


//         var responseJson = json.decode(response.body.toString());



//         if(responseJson['status'] == '1') {



//           setState(

//                   () {



//                 try{

//                   _clientSecret = responseJson['data']['client_secret'];

//                   _paymentMethod = paymentMethod.id.toString();

//                 }catch(e) {

//                   print('Error');

//                 }



//               }

//           );





//           StripePayment.confirmPaymentIntent(



//             PaymentIntent(

//               clientSecret: responseJson['data']['client_secret'] ,

//               paymentMethodId: paymentMethod.id ,

//             ),



//           ).then(



//                   (   paymentIntent     ) {



//                 setState(() {

//                   status_pago = 1;

//                 });



//                 if(status_pago == 1){



//                  Navigator.pop(context, true);  // to  send the order to my Strapi Server



//                 }// if there's Stripe Payment



//               }



//           ).catchError(setError);



//         } else {



//           status_pago = 0;



//           this._showDialog("ERROR",'Verifica los datos de tu Tarjeta 001.', 0);



//         }





//       }

//   ).catchError(setError);



// }