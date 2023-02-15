import 'package:bloc/bloc.dart';
import 'package:blocecommerce/models/models.dart';

import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentLoading()) {
    on<LoadPaymentMethod>(_loadPaymentMethod);
    on<SelectPaymentMethod>(_selectPaymentMethod);
  }
  void _loadPaymentMethod(LoadPaymentMethod event, Emitter<PaymentState> emit) {
    emit(PaymentLoaded());
  }

  void _selectPaymentMethod(
      SelectPaymentMethod event, Emitter<PaymentState> emit) {
    emit(PaymentLoaded(paymentMethod: event.paymentMethod));
  }
}
