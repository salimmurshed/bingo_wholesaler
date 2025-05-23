List<SaleStatusListModel> salesStatusList = [
  SaleStatusListModel(
    status: 0,
    statusDescription: "Sale Pending Approval",
  ),
  SaleStatusListModel(
    status: 1,
    statusDescription: "Sale Approved/Delivered",
  ),
  SaleStatusListModel(
    status: 2,
    statusDescription: "Sale Rejected",
  ),
  SaleStatusListModel(
    status: 3,
    statusDescription: "Sale Proposal Pending Approval",
  ),
  SaleStatusListModel(
    status: 4,
    statusDescription: "Sale Proposal Approved",
  ),
  SaleStatusListModel(
    status: 5,
    statusDescription: "Sale Proposal Rejected",
  ),
  SaleStatusListModel(
    status: 6,
    statusDescription: "Sale Approved",
  ),
  SaleStatusListModel(
    status: 7,
    statusDescription: "Pending Delivery Confirmation",
  ),
  SaleStatusListModel(
    status: 8,
    statusDescription: "Cancelled",
  ),
];

class SaleStatusListModel {
  int status;
  String statusDescription;

  SaleStatusListModel({required this.status, required this.statusDescription});
}
