import { HomeAddNewDevice } from './HomeAddNewDevice'
import { HomeScanCode } from './HomeScanCode'
import { scanCore, scanBarcode } from '@kit.ScanKit';

import { BusinessError } from '@kit.BasicServicesKit';


export let HomeTitleSelectList:Array<SelectOption>=[{value:'我的家'},{value:'???'}];

@Component
export struct HomeTopButton {

  @StorageLink('isAddDeviceSheetShow') isShowAddDevice: boolean = false;

  @State isShowAddGround:boolean=false;

  @State isScanCode:boolean=false;

  @State index:number=1;

  @State codeResult:string='';

  @Builder HomeAddDeviceBuildSheet() {
    HomeAddNewDevice()
  }

  @Builder
  HomeAddGroundBuildSheet() {
    Column()
    {
      Text('没做')
    }
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
          this.isShowAddGround=true;
        })

      MenuItem({content: "扫一扫" })
        .onClick(()=>{
          try {scanBarcode.startScanForResult(getContext(this), { scanTypes: [scanCore.ScanType.ALL], enableMultiMode: true, enableAlbum: true }).then((result: scanBarcode.ScanResult) => {
            let obj:object= JSON.parse(JSON.stringify(result));
            this.codeResult=obj?.["originalValue"];
            if(this.codeResult=='light'){
              this.codeResult='灯';
            }else{
              this.codeResult='错误';
            }
            this.isScanCode =true;
          }).catch((error: BusinessError) => {return});} catch (error) {}
        })

    }

  }

  build() {

    Row(){
      Select(HomeTitleSelectList)
        .selected(0)
        .value(HomeTitleSelectList==null?'暂未创建场景':HomeTitleSelectList[0].value)
        .font({ size: 22, weight: FontWeight.Bolder })
        .fontColor('#182431')
        .selectedOptionFont({ size: 16, weight: 400 })
        .optionFont({ size: 16, weight: 400 })
        .menuAlign(MenuAlignType.START, {dx:0, dy:0})
        .optionWidth(200)
        .optionHeight(300)
        .width('60%')

      Blank()
        .bindSheet($$this.isShowAddGround,this.HomeAddGroundBuildSheet(),
        {
          title:{title:'添加场景',subtitle:'Add a new ground'},
          preferType:SheetType.BOTTOM,

        })

      Blank()
        .bindSheet($$this.isScanCode,this.HomeScanCodeBuildSheet(),
          {
            title:{title:'扫码结果',subtitle:'Result of code'},
            preferType:SheetType.BOTTOM,
            height:300,
          })


      Button(){
        Image($r('app.media.addNew'))
          .height('35')

      }.type(ButtonType.Circle)
      .backgroundColor(Color.White)
      .height('35')
      .bindMenu(this.TopAddMenu())
      .bindSheet($$this.isShowAddDevice,this.HomeAddDeviceBuildSheet(),
        {
          title:{title:'添加设备',subtitle:'Add a new device'},
          preferType:SheetType.BOTTOM,
        })

    }
    .width('90%')

  }

}