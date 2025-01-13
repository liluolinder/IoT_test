import {DefaultHardVibration}from '../../../tools/Vibrator'

@Component
export struct NormalLightCard{

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

    }.width('300')
    .height('250')

  }

  @State isShow:boolean=false
  @State isOpen:boolean=false
  @State lightName:string='卧室的灯'
  @State lightPic:string=''

  build() {

    Column(){
      Image(this.lightPic)
      Blank()
      Toggle({type:ToggleType.Switch,isOn:$$this.isOpen})
      Text(this.lightName)
    }.backgroundColor(Color.White)
    .width(150)
    .height(150)
    .borderRadius('10')
    .clickEffect({level:ClickEffectLevel.LIGHT,scale:0.8})
    .bindContextMenu(this.NoramlLightCardController, ResponseType.LongPress,
      {
        preview: this.NoramlLightCardPreview,
        previewAnimationOptions: {
          hoverScale: [1.0, 0.95]
        },
        onAppear:()=>{DefaultHardVibration()},
      })
    
  }

}