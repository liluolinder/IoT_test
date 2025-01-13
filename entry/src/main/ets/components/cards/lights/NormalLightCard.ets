import {DefaultHardVibration}from '../../../tools/Vibrator'

@Component
export struct NormalLightCard{

  @State isOpen:boolean=false

  @State lightName:string='卧室的灯'
  @State lightPic:string=''

  @Builder
  NoramlLightCardPreview(){
    Column(){

    }.width('300')
    .height('250')
    .backgroundColor('#F1F3F5')
  }

  @Builder
  NoramlLightCardController(){
    Column(){

      Button(){

        Text('开关')

      }.width('90%')
      .height('20')

    }.width('300')
    .height('250')


  }

  build() {

    Column(){
      Image(this.lightPic)
      Blank()
      Toggle({type:ToggleType.Switch,isOn:$$this.isOpen})
      Text(this.lightName)

    }.backgroundColor(Color.White)
    .width(150)
    .height(150)
    .borderRadius('20')
    .clickEffect({level:ClickEffectLevel.LIGHT,scale:0.8})
    .bindContextMenu(this.NoramlLightCardController, ResponseType.LongPress,
      {
        preview: this.NoramlLightCardPreview,

        previewAnimationOptions: {
          hoverScale: [0.8, 0.7]
        },

        onAppear:()=>{DefaultHardVibration()},

      })

  }

}