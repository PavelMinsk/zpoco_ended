@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Order'
define root view entity ZPOCO_I_ORDER
  as select from zpoco_d_order_a
  association [0..1] to ZPOCO_I_TTYPE   as _TType    on $projection.TherapyTypeId  = _TType.TherapyTypeID
  association [0..1] to ZPOCO_I_STSL1   as _StatusL1 on $projection.StatusL1Id     = _StatusL1.StatusL1Id
  association [0..1] to zpoco_i_stsl2   as _StatusL2 on $projection.StatusL2Id     = _StatusL2.StatusL2Id
  association [0..1] to ZPOCO_I_COUNTRY as _Country  on $projection.CountryId      = _Country.CountryId
  association [0..1] to ZPOCO_I_PLANT   as _Plant    on $projection.MfgPlantId     = _Plant.PlantID
  association [0..1] to ZPOCO_I_SITE    as _Site     on $projection.OrderingSiteId = _Site.OrderingSiteId
{
  key order_uuid      as OrderUuid,
      nvs_id          as NvsId,
      therapy         as Therapy,
      country_id      as CountryId,
      mfg_plant_id    as MfgPlantId,
      ttype_id        as TherapyTypeId,
      day0            as Day0,
      stsl1_id        as StatusL1Id,
      stsl2_id        as StatusL2Id,
      ord_site_id     as OrderingSiteId,
      oos             as Oos,
      oos_descr       as OosDescription,
      aph_dewar       as AphDewar,
      fp_dewar        as FpDewar,
      actual_day0     as ActualDay0,
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
      _Country,
      _Plant,
      _StatusL1,
      _StatusL2,
      _TType,
      _Site
}
