import { CacheSHareDataData } from '../../classes/AppStorageV2/CacheShareData';
import {PersonalBodyButtonClass} from '../../classes/PersonalBodyButtonClass'
import { AppStorageV2 } from '@kit.ArkUI';

@ComponentV2
export struct PersonalPrivacyButton{

  @Local cacheSHareDataData:CacheSHareDataData = AppStorageV2.connect(CacheSHareDataData,()=>new CacheSHareDataData())!;

  pathStack: NavPathStack = new NavPathStack();

  @Local personalPrivacyButtonArray:Array<PersonalBodyButtonClass>=[
    new PersonalBodyButtonClass('0','隐私声明摘要','',false),
    new PersonalBodyButtonClass('1','已收集个人信息清单','',false)
  ];

  build() {
    Navigation(this.pathStack){
      Scroll(){

        Column(){
          Column(){
            ForEach(this.personalPrivacyButtonArray,(item:PersonalBodyButtonClass,id:number)=>{

              Button(){

                Row() {

                  Text(item.buttonInfo)
                    .fontColor(Color.Black)
                    .width('90%')

                  Blank()

                  SymbolGlyph($r('sys.symbol.chevron_right')).fontSize(30)

                }

              }.width('100%')
              .height('50')
              .backgroundColor(Color.White)
              .margin('5')
              .borderRadius('10')
              .onClick(()=>
              {
                if(id==0)
                {
                  this.pathStack.pushPathByName(`PrivacyStatementSummary`, null);
                }else{
                  this.pathStack.pushPathByName(`PersonalInformationCollected`, null);

                }

                this.cacheSHareDataData.isLookPrivacyStatement=true;
              })

              if (id < this.personalPrivacyButtonArray.length - 1) {
                Divider().width('90%').color(Color.Black)
              }

            })
          }
          .borderRadius('20')
          .backgroundColor(Color.White)

        }.width('90%')
        .height('100%')

      }.width('100%')
      .height('100%')
      .scrollable(ScrollDirection.Vertical)        //垂直方向滑动
      .scrollBar(BarState.Off)                      //不显示滑动条
      .edgeEffect(EdgeEffect.Spring,{alwaysEnabled: true})    //弹性滑动动效
    }

  }

}