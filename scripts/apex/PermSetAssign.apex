PermissionSet PS = [SELECT id FROM PermissionSet WHERE label = 'RefRecAdmin'];
list<PermissionSetAssignment> Existing = [
  SELECT id
  FROM PermissionSetAssignment
  WHERE AssigneeId = :Userinfo.getUserId() AND PermissionSetId = :PS.Id
];

system.debug(Existing);

if (Existing.isEmpty()) {
  PermissionSetAssignment PSA = new PermissionSetAssignment();
  PSA.AssigneeId = Userinfo.getUserId();
  PSA.PermissionSetId = PS.Id;
  insert PSA;
}
