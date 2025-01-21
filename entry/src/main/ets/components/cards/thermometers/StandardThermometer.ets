import { DefaultHardVibration }from '../../../tools/Vibrator'
import { AppStorageV2 } from "@kit.ArkUI";
import { CustomContentDialog } from '@kit.ArkUI'
import { deleteDataFromRDB, fixStandardThermometerDataFromRDB } from '../../../tools/DoingToRdb';
import { StandardThermometerClass } from '../../../classes/StandardThermometerClass';
import { CacheSHareDataData } from '../../../classes/AppStorageV2/CacheShareData';

@ComponentV2
export struct StandardThermometer{

  @Local cacheSHareDataData:CacheSHareDataData = AppStorageV2.connect(CacheSHareDataData,()=>new CacheSHareDataData())!;

  @Local currentTemp:number=5;

  @Param @Once standardThermometerName:string='温度计';
  @Local standardThermometerNewName:string='';

  @Param @Once scene:string='';
  @Param @Once idInRdb:number=-1;

  @Local standardThermometerPic:Resource=$r('app.media.thermometer');


  @Builder
  StandardThermometerCardPreview(){

    Column(){

      Text(this.standardThermometerName).margin({top:10,bottom:10}).fontSize('22')

      Gauge({value:this.currentTemp,min:-10,max:110}){
        Column(){
          Text('当前温度:'+this.currentTemp)
            .fontWeight(FontWeight.Medium)
            .fontSize("22")
            .textAlign(TextAlign.Center)
            .margin({ top: '100' })
          Text('单位:℃')
            .fontSize('12')
            .fontWeight(FontWeight.Regular)
            .textAlign(TextAlign.Center)
            .margin({top:10})
        }

      }
      .startAngle(225)
      .endAngle(135)
      .height('200')


    }.width('300')
    .height('270')

  }

  @Builder
  StandardThermometerCardControl(){
    Column(){

      Column(){

        Slider({value:$$this.currentTemp,min:-10,max:110,step:1,style:SliderStyle.InSet})
          .showTips(true,(this.currentTemp).toString())
          .onChange(()=>DefaultHardVibration()).margin({top:20})

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
          this.renameDialogController.open();
        })
      MenuItem({content: "删除设备" })
        .onClick(()=>{
          deleteDataFromRDB(this.idInRdb);
          this.cacheSHareDataData.isRefresh=true;
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
          this.standardThermometerName=this.standardThermometerNewName;
          this.standardThermometerNewName=''
          let changeStandardThermometer:StandardThermometerClass=new StandardThermometerClass(this.idInRdb,this.standardThermometerName,this.scene);
          fixStandardThermometerDataFromRDB(changeStandardThermometer);
        }}],
    }),
  });

  @Builder
  Rename(){
    Column() {
      TextInput({placeholder:'请输入新设备名称',text:$$this.standardThermometerNewName})

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

        Image(this.standardThermometerPic).width("20%")
          .margin({bottom:15})

        Text(this.standardThermometerName)
          .margin({bottom:10})

        Progress({value:this.currentTemp+10,total:120,type:ProgressType.Linear})//零下10~零上110(组件最低为0，故+10处理)
          .style({enableSmoothEffect:true,enableScanEffect:true})
          .width('80%')
          .margin({bottom:10})

        Text('当前温度:'+this.currentTemp)


      }.width('90%')
      .height('180')
      .alignItems(HorizontalAlign.Start)

    }
    .backgroundColor(Color.White)
    .width(150)
    .height(200)
    .borderRadius('20')
    .clickEffect({level:ClickEffectLevel.LIGHT})
    .bindContextMenu(this.StandardThermometerCardPreview(), ResponseType.LongPress,
      {
        placement:Placement.Top,
        preview:this.StandardThermometerCardControl,
        previewAnimationOptions: {
          hoverScale: [1, 0.7]
        },

        onAppear:()=>{DefaultHardVibration()},

      })

  }

}