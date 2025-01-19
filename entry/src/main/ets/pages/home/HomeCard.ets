import { NormalLightCard } from '../../components/cards/lights/NormalLightCard'
import { StandardThermometer } from '../../components/cards/thermometers/StandardThermometer'
import { storeRdb } from '../../entryability/EntryAbility'
import { relationalStore } from '@kit.ArkData'
import { BusinessError } from '@kit.BasicServicesKit';


//      'CREATE TABLE IF NOT EXISTS DEVICE_TABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, DEVICE_NAME TEXT NOT NULL , SCENE TEXT NOT NULL , IS_OPEN INTEGER NOT NULL )';

function GetDeviceInfoFromRdb()
{
  let predicates = new relationalStore.RdbPredicates("DEVICE_TABLE");

  predicates.equalTo("SCENE",'我的家');

  if(storeRdb!==undefined)
  {
    (storeRdb as relationalStore.RdbStore).query(predicates, ['ID', 'DEVICE_NAME', 'IS_OPEN','SCENE','DEVICE_TYPE'], (err: BusinessError, resultSet) => {
      if (err) {
        console.error(`Failed to query data. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info(`ResultSet column names: ${resultSet.columnNames}, column count: ${resultSet.columnCount}`);
      // resultSet是一个数据集合的游标，默认指向第-1个记录，有效的数据从0开始。
      while (resultSet.goToNextRow()) {
        const id = resultSet.getLong(resultSet.getColumnIndex('ID'));
        const deviceName = resultSet.getString(resultSet.getColumnIndex('DEVICE_NAME'));
        const isOpen = resultSet.getLong(resultSet.getColumnIndex('IS_OPEN'));
        const scene =resultSet.getString(resultSet.getColumnIndex('SCENE'))
        const deviceType =resultSet.getString(resultSet.getColumnIndex('DEVICE_TYPE'))


        console.info(`id=${id}, name=${deviceName},isOpen=${isOpen},scene=${scene},deviceType=${deviceType}`);

      }
      // 释放数据集的内存
      resultSet.close();
    })
  } 
}


@Component
export struct HomeCard{


  build() {

    Button("134").width('90%')
      .onClick(()=>{GetDeviceInfoFromRdb()})

    /*Grid(){

      ForEach([0,1,2,3,4,5,6,7,8,9,10,11],(id:number)=>{

        GridItem()
        {

        }

      })


    }.columnsTemplate('repeat(auto-stretch, 150)')
    .rowsGap(20)
    .width('90%')
    .height('100%')
    .margin({top:5})
    .scrollBar(BarState.Off)
    .multiSelectable(true)
    .borderRadius('20')
    .edgeEffect(EdgeEffect.Spring,{ alwaysEnabled: true })*/


  }

}