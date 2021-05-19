@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Label'
define root view entity ZPOCO_I_LABEL
  as select from zpoco_d_label_a
  association [0..1] to ZPOCO_I_TTYPE   as _TType    on $projection.TherapyTypeId  = _TType.TherapyTypeID
  association [0..1] to ZPOCO_I_PLANT   as _Plant    on $projection.MfgPlantId     = _Plant.PlantID
{
  key label_uuid      as LabelUuid,
      therapy         as Therapy,
      mfg_plant_id    as MfgPlantId,
      ttype_id        as TherapyTypeId,
      nvs_id          as NvsId,
      printed_labels  as PrintedLabels,
      used_labels     as UsedLabels,
      reconcile       as Reconcile,
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @EndUserText.label : 'Created At'
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @EndUserText.label : 'Last Changed At'
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      _TType,
      _Plant
}
