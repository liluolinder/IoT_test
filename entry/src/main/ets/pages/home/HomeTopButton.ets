import { HomeAddNewDevice } from './HomeAddNewDevice'
import { HomeScanCode } from './HomeScanCode'
import { scanCore, scanBarcode } from '@kit.ScanKit';

import { BusinessError } from '@kit.BasicServicesKit';
import { CacheSHareDataData } from '../../classes/AppStorageV2/CacheShareData';
import { AppStorageV2 } from '@kit.ArkUI';
import { HomeAddNewScene } from './HomeAddNewScene';


@Builder export function HomeTopButtonBuilder()
{
  HomeTopButton()
}



@ComponentV2
export struct HomeTopButton {
  @Local HomeTitleSelectList:Array<SelectOption>=[{value:'我的家'},{value:'???'}];

  @Local cacheSHareDataData:CacheSHareDataData = AppStorageV2.connect(CacheSHareDataData,()=>new CacheSHareDataData())!;

  @Provider('isShowAddDevice') isShowAddDevice: boolean = false;

  @Provider('isShowAddScene') isShowAddScene:boolean=false;

  @Provider('isScanCode')  isScanCode:boolean=false;

  @Local index:number=1;

  @Local codeResult:string='';

  @Builder HomeAddDeviceBuildSheet() {
    HomeAddNewDevice()
  }

  @Builder
  HomeAddGroundBuildSheet() {
    HomeAddNewScene()
  }

  @Builder
  HomeScanCodeBuildSheet()
  {
    HomeScanCode({result1:this.codeResult})
  }

  @Builder
  TopAddMenu(){

    Menu(){

      MenuItem({content: "添加设备" })
        .onClick(()=>{
          this.isShowAddDevice=true;
          })



      MenuItem({content: "创建场景" })
        .onClick(()=>{
          this.isShowAddScene=true;
        })

      MenuItem({content: "扫一扫" })
        .onClick(()=>{
          try {scanBarcode.startScanForResult(getContext(this), { scanTypes: [scanCore.ScanType.ALL], enableMultiMode: true, enableAlbum: true }).then((result: scanBarcode.ScanResult) => {
            let obj:object= JSON.parse(JSON.stringify(result));
            this.codeResult=obj?.["originalValue"];
            if(this.codeResult=='light'){}
            else if(this.codeResult=='thermometer') {}
            else{

              AlertDialog.show({
                title: '啊偶',
                message: '您似乎扫描的不是有效设备二维码哦，亲',
                isModal: true,
                autoCancel: true,
              })

              return
            }
            this.isScanCode =true;
          }).catch((error: BusinessError) => {return});} catch (error) {}
        })

    }

  }

  build() {

    Row(){

      Blank()
        .bindSheet($$this.isShowAddScene,this.HomeAddGroundBuildSheet(),
        {
          title:{title:'添加场景',subtitle:'Add a new ground'},
          height:200,
          preferType:SheetType.BOTTOM,

        })


      Blank()
        .bindSheet($$this.isScanCode,this.HomeScanCodeBuildSheet(),
          {
            title:{title:'扫码结果',subtitle:'Result of code'},
            preferType:SheetType.BOTTOM,

          })


      Button(){
        SymbolGlyph($r('sys.symbol.plus')).fontSize('22')
      }.type(ButtonType.Circle)
      .backgroundColor('#0D000000')
      .bindMenu(this.TopAddMenu())
      .bindSheet($$this.isShowAddDevice,this.HomeAddDeviceBuildSheet(),
        {
          title:{title:'添加设备',subtitle:'Add a new device'},
          preferType:SheetType.BOTTOM,
        })
      .margin({right:10})
      .height('38')
      .width('38')

      Button(){
       SymbolGlyph($r('sys.symbol.dot_grid_2x2')).fontSize('22')

      }.type(ButtonType.Circle)
      .backgroundColor('#0D000000')
      .onClick(()=>{this.cacheSHareDataData.showHomeSideBar=true})
      .height('38')
      .width('38')

    }.alignItems(VerticalAlign.Bottom)

  }

}