enum AssociationActions {
  accepted(1),
  rejected(2),
  verified(3),
  approve(4);

  const AssociationActions(this.value);

  final num value;
}
