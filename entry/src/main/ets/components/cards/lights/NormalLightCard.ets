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

      Progress({value:this.lightBrightness,total:5,type:ProgressType.Ring})
        .style({strokeWidth:16,scaleCount:5,enableScanEffect:true,enableSmoothEffect:true})
        .visibility(this.isOpen?Visibility.Visible:Visibility.Hidden)

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

        Text('灯光强度:').width('95%').textAlign(TextAlign.Start).visibility(this.isOpen?Visibility.Visible:Visibility.Hidden)

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
          this.dialogController.open()
        })
      MenuItem({content: "删除设备" })
        .onClick(()=>{
          promptAction.showToast({
            message: '没做',
          });
        })

    }.width('120')

  }

  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomContentDialog({
      primaryTitle: '重命名',
      secondaryTitle: 'rename',
      contentBuilder: () => {
        this.Rename();
      },
      buttons: [{ value: '取消', buttonStyle: ButtonStyleMode.TEXTUAL,role: ButtonRole.ERROR },
                { value: '确定', buttonStyle: ButtonStyleMode.TEXTUAL,action:()=>{
                  this.normalLightName=this.normalLightNewName;
                    this.normalLightNewName=''
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
        Text('亮度:'+this.lightBrightness)
          .fontSize('15')
          .margin({bottom:10})
          .visibility(this.isOpen?Visibility.Visible:Visibility.Hidden)

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