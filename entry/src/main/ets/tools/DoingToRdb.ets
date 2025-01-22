import { storeRdb } from '../entryability/EntryAbility'
import { relationalStore } from '@kit.ArkData'
import { BusinessError } from '@kit.BasicServicesKit';
import { DeviceClass } from '../classes/DeviceClass'
import { NormalLightClass } from '../classes/NormalLightClass';
import { StandardThermometerClass } from '../classes/StandardThermometerClass';
import { PersistentShareData } from '../classes/PersistenceV2/PersistentShareData';
import { PersistenceV2 } from '@kit.ArkUI';

let localID:number=-1
let localSceneID:number=-1

export let deviceArray:Array<DeviceClass>=[]
export let sceneArraySelect:Array<SelectOption>=[]
export let sceneArray:Array<string>=['全部']


let persistentShareData:PersistentShareData=PersistenceV2.connect(PersistentShareData,()=>new PersistentShareData)!;

export  function GetDeviceInfoFromRdb()
{
  let predicates = new relationalStore.RdbPredicates("DEVICE_TABLE");

  if(storeRdb!==undefined)
  {
    (storeRdb as relationalStore.RdbStore).query(predicates, ['ID', 'DEVICE_NAME','SCENE','DEVICE_TYPE','IS_OPEN','LIGHT_BRIGHTNESS'], (err: BusinessError, resultSet) => {
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
        const isOpen=resultSet.getLong(resultSet.getColumnIndex('IS_OPEN'));
        const lightBrightNess=resultSet.getLong(resultSet.getColumnIndex('LIGHT_BRIGHTNESS'));

        let newDevice:DeviceClass=new DeviceClass(id,deviceName,deviceType,scene,isOpen,lightBrightNess);

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

export  function GetSceneInfoFromRdb()
{
  let predicates = new relationalStore.RdbPredicates("SCENE_TABLE");
  predicates.equalTo("TYPE",'scene');


  if(storeRdb!==undefined)
  {
    (storeRdb as relationalStore.RdbStore).query(predicates, ['ID', 'SCENE'], (err: BusinessError, resultSet) => {
      if (err) {
        console.error(`Failed to query data. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info(`ResultSet column names: ${resultSet.columnNames}, column count: ${resultSet.columnCount}`);
      // resultSet是一个数据集合的游标，默认指向第-1个记录，有效的数据从0开始。
      while (resultSet.goToNextRow()) {
        const id=resultSet.getLong(resultSet.getColumnIndex('ID'));
        const sceneName=resultSet.getString(resultSet.getColumnIndex('SCENE'));

        if(localSceneID<id)
        {
          sceneArraySelect.push({value:sceneName});
          localSceneID=id;
        }
        if(persistentShareData.localSceneID<id)
        {
          persistentShareData.sceneArray.push(sceneName);
          persistentShareData.localSceneID =id;
        }
        console.info(`id=${id}, name=${sceneName}`);
      }
      // 释放数据集的内存
      resultSet.close();
    })
  }
}

export function  deleteDataFromRDB(idInRdb:number)
{
  let predicates = new relationalStore.RdbPredicates("DEVICE_TABLE");
  predicates.equalTo('ID',idInRdb);

  if (storeRdb !== undefined) {
    (storeRdb as relationalStore.RdbStore).delete(predicates, (err: BusinessError, rows: number) => {
      if (err) {
        console.error(`Failed to delete data. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info(`Delete rows: ${rows}`);

      deviceArray.splice(0,deviceArray.length);

      localID=-1;
    })
  }
}

export function  fixNormalLightDataFromRDB(device:NormalLightClass)
{
  const valueBucket: relationalStore.ValuesBucket = {
    'DEVICE_NAME': device.deviceName,
    'SCENE' :  device.scene,
    'IS_OPEN' : device.isOpen,
    'LIGHT_BRIGHTNESS' : device.lightBrightness,
  };

  let predicates = new relationalStore.RdbPredicates("DEVICE_TABLE");

  predicates.equalTo('ID',device.id);

  if (storeRdb !== undefined) {
    (storeRdb as relationalStore.RdbStore).update(valueBucket, predicates, (err: BusinessError, rows: number) => {
      if (err) {
        console.error(`Failed to update data. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info(`Succeeded in updating data. row count: ${rows}`);
    })
  }
}

export function  fixStandardThermometerDataFromRDB(device:StandardThermometerClass)
{
  const valueBucket: relationalStore.ValuesBucket = {
    'DEVICE_NAME': device.deviceName,
    'SCENE' :  device.scene,
  };

  let predicates = new relationalStore.RdbPredicates("DEVICE_TABLE");

  predicates.equalTo('ID',device.id);

  if (storeRdb !== undefined) {
    (storeRdb as relationalStore.RdbStore).update(valueBucket, predicates, (err: BusinessError, rows: number) => {
      if (err) {
        console.error(`Failed to update data. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info(`Succeeded in updating data. row count: ${rows}`);
    })
  }
}