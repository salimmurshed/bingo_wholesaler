class InvoiceModel {
  int? id;
  String? invoiceTo;
  String? dateOfInvoice;
  String? amount;
  String? paymentDuration;
  String? sNo;
  String? status;

  InvoiceModel(
      {this.id,
      this.invoiceTo,
      this.dateOfInvoice,
      this.amount,
      this.paymentDuration,
      this.sNo,
      this.status});
}
