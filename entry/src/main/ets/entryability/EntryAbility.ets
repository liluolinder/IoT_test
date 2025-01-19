import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { relationalStore } from '@kit.ArkData'; // 导入模块
import { GetDeviceInfoFromRdb } from '../tools/GetDeviceInfoFromRdb'


export let storeRdb:relationalStore.RdbStore

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;

      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');

    });

    PersistentStorage.persistProp('isAddDeviceSheetShow', false);

    const STORE_CONFIG :relationalStore.StoreConfig= {
      name: 'iotDeviceRdb.db', // 数据库文件名
      securityLevel: relationalStore.SecurityLevel.S2, // 数据库安全级别
      encrypt: false, // 可选参数，指定数据库是否加密，默认不加密
      customDir: 'customDir/Store', // 可选参数，数据库自定义路径。数据库将在如下的目录结构中被创建：context.databaseDir + '/rdb/' + customDir，其中context.databaseDir是应用沙箱对应的路径，'/rdb/'表示创建的是关系型数据库，customDir表示自定义的路径。当此参数不填时，默认在本应用沙箱目录下创建RdbStore实例。
      isReadOnly: false // 可选参数，指定数据库是否以只读方式打开。该参数默认为false，表示数据库可读可写。该参数为true时，只允许从数据库读取数据，不允许对数据库进行写操作，否则会返回错误码801。
    };

    const SQL_CREATE_DEVICE_TABLE =
      'CREATE TABLE IF NOT EXISTS DEVICE_TABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, DEVICE_NAME TEXT NOT NULL , DEVICE_TYPE TEXT NOT NULL, SCENE TEXT NOT NULL , IS_OPEN INTEGER )'; // 建表Sql语句, IDENTITY为bigint类型，sql中指定类型为UNLIMITED INT


    const SQL_CREATE_SCENE_TABLE =
      'CREACREATE TABLE IF NOT EXISTS SCENE_TABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, SCENE TEXT NOT NULL  )'; // 建表Sql语句, IDENTITY为bigint类型，sql中指定类型为UNLIMITED INT


    relationalStore.getRdbStore(this.context , STORE_CONFIG , (err,store) =>{

      if(err){
        console.error(`Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info('Succeeded in getting RdbStore.');

      storeRdb=store;

      if (store.version === 0) {
        store.executeSql(SQL_CREATE_DEVICE_TABLE); // 创建数据表
        store.executeSql(SQL_CREATE_SCENE_TABLE); // 创建数据表
        // 设置数据库的版本，入参为大于0的整数
        store.version = 1;
      }

    })


;
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestoy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to backgroundr
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}