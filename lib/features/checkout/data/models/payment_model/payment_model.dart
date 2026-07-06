import 'amount_details.dart';
import 'automatic_payment_methods.dart';
import 'managed_payments.dart';
import 'payment_method_configuration_details.dart';
import 'payment_method_options.dart';

class PaymentModel {
  String? id;
  String? object;
  int? amount;
  int? amountCapturable;
  AmountDetails? amountDetails;
  int? amountReceived;
  dynamic application;
  dynamic applicationFeeAmount;
  AutomaticPaymentMethods? automaticPaymentMethods;
  dynamic canceledAt;
  dynamic cancellationReason;
  String? captureMethod;
  String clientSecret;
  String? confirmationMethod;
  int? created;
  String? currency;
  dynamic customer;
  dynamic customerAccount;
  dynamic description;
  dynamic excludedPaymentMethodTypes;
  dynamic lastPaymentError;
  dynamic latestCharge;
  bool? livemode;
  ManagedPayments? managedPayments;
  dynamic nextAction;
  dynamic onBehalfOf;
  dynamic paymentMethod;
  PaymentMethodConfigurationDetails? paymentMethodConfigurationDetails;
  PaymentMethodOptions? paymentMethodOptions;
  List<String>? paymentMethodTypes;
  dynamic processing;
  dynamic receiptEmail;
  dynamic review;
  dynamic setupFutureUsage;
  dynamic sharedPaymentGrantedToken;
  dynamic shipping;
  dynamic source;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String? status;
  dynamic transferData;
  dynamic transferGroup;

  PaymentModel({
    this.id,
    this.object,
    this.amount,
    this.amountCapturable,
    this.amountDetails,
    this.amountReceived,
    this.application,
    this.applicationFeeAmount,
    this.automaticPaymentMethods,
    this.canceledAt,
    this.cancellationReason,
    this.captureMethod,
    required this.clientSecret,
    this.confirmationMethod,
    this.created,
    this.currency,
    this.customer,
    this.customerAccount,
    this.description,
    this.excludedPaymentMethodTypes,
    this.lastPaymentError,
    this.latestCharge,
    this.livemode,
    this.managedPayments,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    this.paymentMethodConfigurationDetails,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.processing,
    this.receiptEmail,
    this.review,
    this.setupFutureUsage,
    this.sharedPaymentGrantedToken,
    this.shipping,
    this.source,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status,
    this.transferData,
    this.transferGroup,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    id: json['id'] as String?,
    object: json['object'] as String?,
    amount: json['amount'] as int?,
    amountCapturable: json['amount_capturable'] as int?,
    amountDetails: json['amount_details'] == null
        ? null
        : AmountDetails.fromJson(
            json['amount_details'] as Map<String, dynamic>,
          ),
    amountReceived: json['amount_received'] as int?,
    application: json['application'] as dynamic,
    applicationFeeAmount: json['application_fee_amount'] as dynamic,
    automaticPaymentMethods: json['automatic_payment_methods'] == null
        ? null
        : AutomaticPaymentMethods.fromJson(
            json['automatic_payment_methods'] as Map<String, dynamic>,
          ),
    canceledAt: json['canceled_at'] as dynamic,
    cancellationReason: json['cancellation_reason'] as dynamic,
    captureMethod: json['capture_method'] as String?,
    clientSecret: json['client_secret'] as String,
    confirmationMethod: json['confirmation_method'] as String?,
    created: json['created'] as int?,
    currency: json['currency'] as String?,
    customer: json['customer'] as dynamic,
    customerAccount: json['customer_account'] as dynamic,
    description: json['description'] as dynamic,
    excludedPaymentMethodTypes:
        json['excluded_payment_method_types'] as dynamic,
    lastPaymentError: json['last_payment_error'] as dynamic,
    latestCharge: json['latest_charge'] as dynamic,
    livemode: json['livemode'] as bool?,
    managedPayments: json['managed_payments'] == null
        ? null
        : ManagedPayments.fromJson(
            json['managed_payments'] as Map<String, dynamic>,
          ),
    nextAction: json['next_action'] as dynamic,
    onBehalfOf: json['on_behalf_of'] as dynamic,
    paymentMethod: json['payment_method'] as dynamic,
    paymentMethodConfigurationDetails:
        json['payment_method_configuration_details'] == null
        ? null
        : PaymentMethodConfigurationDetails.fromJson(
            json['payment_method_configuration_details']
                as Map<String, dynamic>,
          ),
    paymentMethodOptions: json['payment_method_options'] == null
        ? null
        : PaymentMethodOptions.fromJson(
            json['payment_method_options'] as Map<String, dynamic>,
          ),
    paymentMethodTypes: (json['payment_method_types'] as List<dynamic>?)
        ?.cast<String>(),
    processing: json['processing'] as dynamic,
    receiptEmail: json['receipt_email'] as dynamic,
    review: json['review'] as dynamic,
    setupFutureUsage: json['setup_future_usage'] as dynamic,
    sharedPaymentGrantedToken: json['shared_payment_granted_token'] as dynamic,
    shipping: json['shipping'] as dynamic,
    source: json['source'] as dynamic,
    statementDescriptor: json['statement_descriptor'] as dynamic,
    statementDescriptorSuffix: json['statement_descriptor_suffix'] as dynamic,
    status: json['status'] as String?,
    transferData: json['transfer_data'] as dynamic,
    transferGroup: json['transfer_group'] as dynamic,
  );
}
