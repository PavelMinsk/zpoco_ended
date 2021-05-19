@AbapCatalog.sqlViewName: 'ZPOCOOVPCARDSORD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'OVP Cards for Order'

---------------------------------------------------------------------

@UI.chart: [
            {  //chart  Maximum for a sample of Therapies
              qualifier:             'TherapyMaxQuan',
              chartType:             #LINE,
              dimensions:          [ 'PlantName'],
              measures:            [ 'TherapyCount2'],
              dimensionAttributes: [{ dimension: 'PlantName',     role: #CATEGORY }],
              measureAttributes:   [{ measure:   'TherapyCount2', role: #AXIS_1 }]
            },
           ------------------
            {  //chart  Quantity of Therapies by Status 
                //Tab1
              qualifier:             'QuantityByL1',
              title:                 'By L1 Status for the Last Year',
              chartType:              #DONUT,
              dimensions:          [ 'StatusL1Name'],
              measures:            [ 'TherapyCount3'],
              dimensionAttributes: [{ dimension: 'StatusL1Name',  role: #CATEGORY }],
              measureAttributes:   [{ measure:   'TherapyCount3', role: #AXIS_1 }]
            },
            {   //Tab2
              qualifier:             'QuantityByL2',
              title:                 'By L2 Status for the Last Year',
              chartType:              #DONUT,
              dimensions:          [ 'StatusL2Name'],
              measures:            [ 'TherapyCount3'],
              dimensionAttributes: [{ dimension: 'StatusL2Name',  role: #CATEGORY }],
              measureAttributes:   [{ measure:   'TherapyCount3', role: #AXIS_1 }]
            },
           ------------------
            { //Therapy by types
              qualifier:            'ThByTyPeriods',
              chartType:             #COLUMN_STACKED,
              dimensions:          ['Therapy', 'TherapyTypeName'],
              measures:            ['TherapyTypeCount'],
              dimensionAttributes: [{ dimension: 'Therapy',          role: #CATEGORY },
                                    { dimension: 'TherapyTypeName',  role: #SERIES   } ],
              measureAttributes:   [{ measure:   'TherapyTypeCount', role: #AXIS_1 }]
            }           
           ]

@UI.presentationVariant: [
                          { //table  Therapy By Plant
                            qualifier:      'pvTherapyDateQuan',
                            visualizations: [{ 
                                               type: #AS_LINEITEM, 
                                               qualifier: 'TherapyDateQuan' 
                                            }]
                          },
                         -------------- 
                          { //chart  Maximum for a sample of Therapies
                            qualifier:      'pvTherapyMaxQuan',
                            visualizations: [{ 
                                               type: #AS_CHART, 
                                               qualifier: 'TherapyMaxQuan' 
                                            }]
                          },
                          { //kpi for Maximum for a sample of Therapies
                            qualifier:      'pvKPITherapyMaxQuan',
                            text:           'KPI: Quatity of Therapies by Plants',
                            visualizations: [{
                                               type:      #AS_DATAPOINT,
                                               qualifier: 'dpTherapyMaxQuan'
                                            }]
                          },
                          -------------
                          { //chart  Quantity of Therapies by Status 
                              //Tab1
                            qualifier:      'pvQuantityByL1',
                            visualizations: [{ 
                                               type: #AS_CHART, 
                                               qualifier: 'QuantityByL1' 
                                            }]
                          },
                          {   //Tab2
                            qualifier:      'pvQuantityByL2',
                            visualizations: [{ 
                                               type: #AS_CHART, 
                                               qualifier: 'QuantityByL2' 
                                            }]
                          
                          },
                         -------------- 
                          { //list  The Therapy Quantity for the Last Year
                            qualifier:      'pvTherapyDateSumList',
                            visualizations: [{ 
                                               element: 'TherapyCount4'
                                            }]
                          },
//                          { //kpi for The list  Therapy Quantity for the Last Year
//                            qualifier:      'pvKPITherapyDateSumList',
//                            text:           'KPI: Quatity of Therapies by Plants',
//                            visualizations: [{
//                                               type:      #AS_DATAPOINT,
//                                               qualifier: 'dpTherapyDateSumList'
//                                            }]
//                          }
                         -------------- 
                          { //Therapy by types
                            qualifier:      'pvThByTyPeriods',
                            visualizations: [{ 
                                               type: #AS_CHART, 
                                               qualifier: 'ThByTyPeriods' 
                                            }]
                          
                          }
                          
                         ]
                         

---------------------------------------------------------------------

define view zpoco_c_ovp_cards_order
  as select from zpoco_i_order_for_ovp
{
//  key OrderUuid,
//      NvsId,
--------      
         @UI.lineItem: [
                        { 
                          qualifier:'TherapyDateQuan', 
                          position:10,
                          importance:#HIGH 
                        },
                        { 
                          qualifier:'TherapyDateSumList', 
                          //type:       #AS_DATAPOINT,
                          position:10
                        }
                       ]
         @Consumption.semanticObject: 'NBS_POC_OVP_ORDER'
         @UI.identification: [{ semanticObjectAction: 'manage',
                                type:                  #FOR_INTENT_BASED_NAVIGATION }]
   key   Therapy,
   key   TherapyTypeName,

      
      @UI.lineItem: [
                      { qualifier:'TherapyDateQuan', 
                        position:20,
                        importance:#HIGH },
                      { qualifier:'liTherapyMaxQuan', 
                        position:20,
                        importance:#HIGH }
                    ]
      key PlantName,
      
      @UI:{
            lineItem: [{ 
                         qualifier: 'TherapyDateSumList',
                         type:       #AS_DATAPOINT, 
                         position:   20, 
                         importance: #HIGH 
                      }],
            
            dataPoint: { title: 'By Date' }
          }
      Day0,
      
      @EndUserText.label: 'L1'
      StatusL1Name,
      @EndUserText.label: 'L2'
      StatusL2Name,
      
---------      
      @UI:{
            lineItem: [{ qualifier: 'TherapyDateQuan', 
                         position:   30,
                         importance: #HIGH}]
          }
      MfgPlantId,
      
      TtypeId,
      OrderCreatedDay,
      Stsl1Id,
      Stsl2Id,
--------      

      @UI:{
            lineItem: [{ 
                         qualifier: 'TherapyDateQuan', 
                         position:   40,
                         type:       #AS_DATAPOINT,
                         importance: #HIGH 
                      }],
            
            dataPoint: { qualifier:   'dpTherapyDateQuan',
                         maximumValue: 70,
                         criticalityCalculation: { improvementDirection: #MAXIMIZE,
                                                   deviationRangeLowValue: 40,
                                                   toleranceRangeLowValue: 30 }
                       }
          }          
//      @UI:{
//            lineItem: [{ qualifier: 'TherapyDateQuan', 
//                         position:   40                         }]
//                        }          
//      
      @EndUserText.label: 'Therapy Quantity'
      @Aggregation.default: #SUM
      TherapyCount,
      
       
      @UI:{
            lineItem:  [                      
                        { 
                          importance: #HIGH,
                          label:     'Max. Quantity',
                          type:       #AS_DATAPOINT 
                        }
                       ],
            
            dataPoint: { qualifier: 'dpTherapyMaxQuan',
                         
                         criticalityCalculation: { improvementDirection: #MAXIMIZE,
                                                   toleranceRangeLowValue: 40,
                                                   deviationRangeLowValue: 30 },
                         
                         trendCalculation:       { referenceValue:'TargetValue' ,
                                                   downDifference: 0,
                                                   upDifference: 0 } 
                       }
          }          
      @Aggregation.default: #SUM
      TherapyCount2 ,
      TargetValue ,
     
      @UI.lineItem: [{ type: #AS_DATAPOINT }]
      @UI.dataPoint: { qualifier: 'dpQuantityByL', 
                       visualization: #NUMBER,
                       maximumValue: 70,
                       criticalityCalculation: { improvementDirection: #MAXIMIZE,
                                                 deviationRangeLowValue: 40,
                                                 toleranceRangeLowValue: 30 }
                     }
      @Aggregation.default: #SUM
      TherapyCount3,
      
      
      @UI:{
            lineItem:  [                      
                        { 
                          qualifier: 'TherapyDateSumList',
                          position:   10,
                          //type:       #AS_DATAPOINT, 
                          importance: #HIGH
                        }
                       ],
            
            dataPoint: { qualifier:   'dpTherapyDateSumList',
                         minimumValue: 0,
                         maximumValue: 70,
                         criticalityCalculation: { improvementDirection: #MAXIMIZE,
                                                   toleranceRangeLowValue: 40,
                                                   deviationRangeLowValue: 30 },
                         trendCalculation: { referenceValue:'TargetValue' ,
                                             downDifference: 0,
                                             upDifference:   0 }
                       }
          }          
      @Aggregation.default: #SUM
      TherapyCount4,
      

      @Aggregation.default: #SUM
      @EndUserText.label: 'Therapy Type Quantity'
      TherapyTypeCount


} 
