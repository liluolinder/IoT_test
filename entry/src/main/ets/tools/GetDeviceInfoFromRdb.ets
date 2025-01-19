import { storeRdb } from '../entryability/EntryAbility'
import { relationalStore } from '@kit.ArkData'
import { BusinessError } from '@kit.BasicServicesKit';
import { DeviceClass } from '../classes/DeviceClass'

export let deviceArray:Array<DeviceClass>=[]

let localID:number=-1

export  function GetDeviceInfoFromRdb()
{

  let predicates = new relationalStore.RdbPredicates("DEVICE_TABLE");

  predicates.equalTo("SCENE",'我的家');

  if(storeRdb!==undefined)
  {
    (storeRdb as relationalStore.RdbStore).query(predicates, ['ID', 'DEVICE_NAME','SCENE','DEVICE_TYPE'], (err: BusinessError, resultSet) => {
      if (err) {
        console.error(`Failed to query data. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info(`ResultSet column names: ${resultSet.columnNames}, column count: ${resultSet.columnCount}`);
      // resultSet是一个数据集合的游标，默认指向第-1个记录，有效的数据从0开始。
      while (resultSet.goToNextRow()) {
        const id = resultSet.getLong(resultSet.getColumnIndex('ID'));
        const deviceName = resultSet.getString(resultSet.getColumnIndex('DEVICE_NAME'));
        const scene =resultSet.getString(resultSet.getColumnIndex('SCENE'));
        const deviceType =resultSet.getString(resultSet.getColumnIndex('DEVICE_TYPE'));

        let newDevice:DeviceClass=new DeviceClass(id,deviceName,deviceType,scene);

        if(localID<id)
        {
          deviceArray.push(newDevice);
          localID=id;
        }



        console.info(`id=${id}, name=${deviceName},scene=${scene},deviceType=${deviceType}`);
      }
      // 释放数据集的内存
      resultSet.close();
    })
  }
}
