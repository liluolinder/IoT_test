import { DefaultHardVibration }from '../../../tools/Vibrator'
import { promptAction } from "@kit.ArkUI";
import { CustomContentDialog } from '@kit.ArkUI'

@Component
export struct NormalLightCard{

  @State isOpen:boolean=false

  @State lightBrightness:number=1

  @State normalLightName:string='卧室的灯'
  @State normalLightNewName:string=''

  @State normalLightOff:Resource=$r('app.media.normalLightOff')
  @State normalLightOn:Resource=$r('app.media.normalLightOn')
  @State test:Resource=$r('app.media.test1')

  @Builder
  NormalLightCardPreview(){

    Column(){

      Text(this.normalLightName).margin({top:10,bottom:20}).fontSize('22')

      Row(){
        Image(this.isOpen?this.normalLightOn:this.normalLightOff)
          .height('150')

        Blank()

        Stack(){
          Progress({value:this.lightBrightness,total:5,type:ProgressType.Ring})
            .style({strokeWidth:16,scaleCount:5,enableScanEffect:true,enableSmoothEffect:true})
            .height('130')

          Text('灯光亮度')
        }.visibility(this.isOpen?Visibility.Visible:Visibility.Hidden)

      }.width('90%')



    }.width('300')
    .height('250')

  }

  @Builder
  NormalLightCardController(){
    Column(){

      Column(){
        Toggle({ type: ToggleType.Button, isOn: $$this.isOpen }) {
          Text(this.isOpen?'已开启':'已关闭').fontColor(Color.Black).fontSize(12)
        }.width('95%')
        .height('40')
        .selectedColor('rgba(0,125,255,0.20)')
        .margin({top:10,bottom:20})
        .onChange(()=>DefaultHardVibration())

        Text('灯光亮度:').width('95%').textAlign(TextAlign.Start).visibility(this.isOpen?Visibility.Visible:Visibility.Hidden)

        Slider({value:$$this.lightBrightness,min:1,max:5,step:1,style:SliderStyle.InSet})
          .showSteps(true)
          .showTips(true,this.lightBrightness.toString())
          .visibility(this.isOpen?Visibility.Visible:Visibility.Hidden)
          .onChange(()=>DefaultHardVibration())

      }.backgroundColor(Color.White)
      .width('88%')
      .margin({top:10})
      .borderRadius('20')

    }.width('300')
    .height('150')
    .backgroundColor('#F1F3F5')
  }

  @Builder
  TopEditMenu(){

    Menu(){
      MenuItem({content: "重命名" })
        .onClick(()=>{
          this.renameDialogController.open()
        })
      MenuItem({content: "删除设备" })
        .onClick(()=>{
          promptAction.showToast({
            message: '没做',
          });
        })

    }.width('120')

  }

  renameDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomContentDialog({
      primaryTitle: '重命名',
      secondaryTitle: 'rename',
      contentBuilder: () => {
        this.Rename();
      },
      buttons: [{ value: '取消', buttonStyle: ButtonStyleMode.TEXTUAL,role: ButtonRole.ERROR },
                { value: '确定', buttonStyle: ButtonStyleMode.TEXTUAL,action:()=>{
                  if(this.normalLightNewName!=''){
                    this.normalLightName=this.normalLightNewName;
                    this.normalLightNewName='';
                  }else{
                    
                  }
                }}],
    }),
  });

  @Builder
  Rename(){
    Column() {
      TextInput({placeholder:'请输入新设备名称',text:$$this.normalLightNewName})

    }
  }


  build() {
    Column(){
      Row(){
        Blank()
        Button(){
          SymbolGlyph($r('sys.symbol.dot_grid_1x2')).fontSize('25').backgroundColor(Color.White)
        }.type(ButtonType.Circle)
        .bindMenu(this.TopEditMenu())

      }.width('90%')
      .margin('10')
      Column(){

        Image(this.isOpen?this.normalLightOn:this.normalLightOff).width("20%")
          .margin({bottom:15})
        Text(this.normalLightName)
          .margin({bottom:10})
        /*Text('亮度:'+this.lightBrightness)
          .fontSize('15')
          .margin({bottom:10})
          .visibility(this.isOpen?Visibility.Visible:Visibility.Hidden)*/

        DataPanel({values:[this.lightBrightness],max:5,type: DataPanelType.Line})
          .width('100')
          .height('8')
          .margin({bottom:10})
          .visibility(this.isOpen?Visibility.Visible:Visibility.Hidden)
//https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V13/ts-basic-components-datapanel-V13#colorstop10

        Toggle({type:ToggleType.Switch,isOn:$$this.isOpen})

      }.width('90%')
      .height('180')
      .alignItems(HorizontalAlign.Start)


    }
    .backgroundColor(Color.White)
    .width(150)
    .height(200)
    .borderRadius('20')
    .clickEffect({level:ClickEffectLevel.LIGHT})
    .bindContextMenu(this.NormalLightCardPreview, ResponseType.LongPress,
      {
        placement:Placement.Top,
        preview: this.NormalLightCardController(),

        previewAnimationOptions: {
          hoverScale: [1, 0.7]
        },

        onAppear:()=>{DefaultHardVibration()},

      })

  }

}