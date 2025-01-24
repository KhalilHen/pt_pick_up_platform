enum OrderStatus {
  Pending,
  Accepted,
  Rejected,
  Kitchen,
  Cancelled,
  ReadyForPickUp,
  Completed,
  Unknown,
}

enum CustomerOrderStatus {
  Confirmed,
  Preparing,
  ReadyForPickUp,
  Completed,
}

enum InitialOrderState { Pending, Accepted, Cancelled }
