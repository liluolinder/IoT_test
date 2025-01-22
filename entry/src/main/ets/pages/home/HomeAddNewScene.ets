import { DeviceClass, newDeviceClass} from '../../classes/DeviceClass'
import { relationalStore } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import { storeRdb } from '../../entryability/EntryAbility'
import { CacheSHareDataData } from '../../classes/AppStorageV2/CacheShareData';
import { AppStorageV2 } from '@kit.ArkUI';

@ComponentV2
export struct HomeAddNewScene{

  @Local cacheSHareDataData:CacheSHareDataData = AppStorageV2.connect(CacheSHareDataData,()=>new CacheSHareDataData())!;

  @Local addNewSceneName:string='';

  @Local valueBucket: relationalStore.ValuesBucket | undefined= undefined

  @Consumer('isShowAddScene') isShowAddScene:boolean=false;

  build() {
    Column(){
      TextInput({placeholder:'请输入新场景名称',text:$$this.addNewSceneName})
        .margin({bottom:10})
        .width('100%')
      Button("确定")

        .onClick(()=>{
          this.valueBucket = {
            'SCENE':this.addNewSceneName,
            'TYPE':'scene'
          }
          if (storeRdb !== undefined) {
            (storeRdb as relationalStore.RdbStore).insert('SCENE_TABLE', this.valueBucket, (err: BusinessError, rowId: number) => {
              if (err) {
                console.error(`Failed to insert data. Code:${err.code}, message:${err.message}`);
                return;
              }
              console.info(`Succeeded in inserting data. rowId:${rowId}`);
            })
          }

         this.isShowAddScene=false;
          setTimeout(()=>{this.cacheSHareDataData.isRefresh=true;}
            ,50)

        })
    }

  }

}