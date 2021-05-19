@AbapCatalog.sqlViewName: 'ZPOCOORDFOROVP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Order for OVP'


define view zpoco_i_order_for_ovp
  as select from zpoco_d_order_a
  
  association [0..1] to ZPOCO_I_TTYPE     as _TType              on  $projection.TtypeId    = _TType.TherapyTypeID
  association [0..1] to ZPOCO_I_STSL1     as _StatusL1           on  $projection.Stsl1Id    = _StatusL1.StatusL1Id
  association [0..1] to zpoco_i_stsl2     as _StatusL2           on  $projection.Stsl2Id    = _StatusL2.StatusL2Id
  association [0..1] to ZPOCO_I_PLANT     as _Plant              on  $projection.MfgPlantId = _Plant.PlantID
  
{
  key order_uuid                          as OrderUuid,
      nvs_id                              as NvsId,
      
      therapy                             as Therapy,
      case when therapy is not initial 
           then 1
           else 0
      end                                as TherapyCount,
      
      case when therapy is not initial 
           then 1
           else 0
      end                                as TherapyCount2, 
      
      case when therapy is not initial 
           then 1
           else 0
      end                                as TherapyCount3, 
      
      case when therapy is not initial 
           then 1
           else 0
      end                                as TherapyCount4, 
      
      case when therapy is not initial 
           then 1
      end                                as MaxTherapyQuantity,
      
      cast(40 as abap.int1)              as TargetValue,    
      
      mfg_plant_id                       as MfgPlantId,
      _Plant.PlantName                   as PlantName,
      
      ttype_id                           as TtypeId,
      _TType.TherapyTypeName             as TherapyTypeName,
      case when ttype_id is not initial 
           then 1
           else 0
      end                                as TherapyTypeCount,
      
      @EndUserText.label : 'Order Created Day'
      dats_add_days(day0, -5, 'INITIAL') as OrderCreatedDay,      
      
      day0                               as Day0,
      
      stsl1_id                           as Stsl1Id,
      _StatusL1.StatusL1Name             as StatusL1Name,
      
      stsl2_id                           as Stsl2Id,
      _StatusL2.StatusL2Name             as StatusL2Name,

      --Associations--

      _Plant,
      _StatusL1,
      _StatusL2,
      _TType
      

}
