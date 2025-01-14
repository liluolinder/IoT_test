import { promptAction } from "@kit.ArkUI";
import { HomeAddNewDevice } from './HomeAddNewDevice'

@Component
export struct HomeTopButton {

  @State isShowAddDevice:boolean=false
  @State isShowAddGround:boolean=false



  @State HomeTitleSelectList:Array<SelectOption>=[{value:'我的家'},{value:'???'}];
  @State index:number=1;

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
          promptAction.showToast({
            message: '没做',
          });
        })

    }

  }

  build() {

    Row(){
      Select(this.HomeTitleSelectList)
        .selected(0)
        .value(this.HomeTitleSelectList==null?'暂未创建场景':this.HomeTitleSelectList[0].value)
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

        })

    }
    .width('90%')

  }

}