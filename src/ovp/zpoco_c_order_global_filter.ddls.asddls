@AbapCatalog.sqlViewName: 'ZPOCOORDERGLFIL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Order Global Filter for OVP'
@Search.searchable: true


define view zpoco_c_order_global_filter
  as select from zpoco_d_order_a
  
  association [0..1] to ZPOCO_I_TTYPE     as _TType              on  $projection.TtypeId    = _TType.TherapyTypeID
  association [0..1] to ZPOCO_I_STSL1     as _StatusL1           on  $projection.Stsl1Id    = _StatusL1.StatusL1Id
  association [0..1] to zpoco_i_stsl2     as _StatusL2           on  $projection.Stsl2Id    = _StatusL2.StatusL2Id
  association [0..1] to ZPOCO_I_PLANT     as _Plant              on  $projection.MfgPlantId = _Plant.PlantID
  
{
      @UI.hidden: true
  key order_uuid                        as OrderUuid,
      
      @UI.hidden: true
      @Search: {
          defaultSearchElement: true,
          ranking: #HIGH,
          fuzzinessThreshold: 0.8
      }
      nvs_id                            as NvsId,
      
      @UI:{
            lineItem:       [{ position: 20, importance: #HIGH }],
            selectionField: [{ position: 15 }] 
          }
      @Consumption.valueHelpDefinition: [{ 
                                           entity: { name:    'ZPOCO_C_ORDER',   
                                                     element: 'Therapy'} 
                                        }]
      therapy                           as Therapy,
      
      @UI:{
            lineItem:       [{ position: 40, importance: #HIGH }],
            selectionField: [{ position: 40 }] 
          }
      @Consumption.valueHelpDefinition: [{ 
                                           entity: { name:    'zpoco_i_plant',   
                                                     element: 'PlantID'} 
                                        }]          
      @ObjectModel.text.element: ['PlantName']
      mfg_plant_id                      as MfgPlantId,
      _Plant.PlantName                  as PlantName,
      
      
      @UI:{
            lineItem:       [{ position: 50, importance: #HIGH }],
            selectionField: [{ position: 50 }] 
          }
      @Consumption.valueHelpDefinition: [{ 
                                           entity: { name:    'zpoco_i_ttype',   
                                                     element: 'TherapyTypeName'} 
                                        }]
      @ObjectModel.text.element: ['TherapyTypeName']
      ttype_id                          as TtypeId,
      _TType.TherapyTypeName            as TherapyTypeName,
      
      @UI:{
            lineItem:       [{ position: 70, importance: #MEDIUM }],
            selectionField: [{ position: 70 }] 
          }
      @Consumption.filter: { selectionType: #INTERVAL , multipleSelections:  false }
      day0                              as Day0,
      
            
      @UI:{
            lineItem:       [{ position: 80, importance: #HIGH }],
            selectionField: [{ position: 80 }] 
          }
      @Consumption.valueHelpDefinition: [{ 
                                           entity: { name:    'zpoco_i_stsl1',   
                                                     element: 'StatusL1Id'} 
                                        }]
      stsl1_id                          as Stsl1Id,
      _StatusL1.StatusL1Name            as StatusL1Name,
      
      @UI:{
            lineItem:       [{ position: 90, importance: #HIGH }],
            selectionField: [{ position: 90 }] 
          }
      @Consumption.valueHelpDefinition: [{ 
                                           entity: { name:    'zpoco_i_stsl2',   
                                                     element: 'StatusL2Id'} 
                                        }]
      stsl2_id                          as Stsl2Id,
      
                  
      --Assosiations--
      _Plant,
      _StatusL1,
      _StatusL2,
      _TType
}
