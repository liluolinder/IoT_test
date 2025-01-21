import { CacheSHareDataData } from "../../classes/AppStorageV2/CacheShareData";
import { AppStorageV2 } from "@kit.ArkUI";

@Builder export function PersonalInformationCollectedBuilder()
{
  PersonalInformationCollected()
}

@ComponentV2
export struct PersonalInformationCollected{

  @Local cacheSHareDataData:CacheSHareDataData = AppStorageV2.connect(CacheSHareDataData,()=>new CacheSHareDataData())!;

  pathStack: NavPathStack = new NavPathStack();

  build() {

    NavDestination(){
      Column(){


      }.height('100%')
      .width('90%')
      .backgroundColor(Color.White)
      .borderRadius('20')

    }.onReady((ctx: NavDestinationContext) => {
      //NavDestinationContext获取当前所在的页面栈
      this.pathStack = ctx.pathStack ;
    })
    .onWillDisappear(()=>this.cacheSHareDataData.isLookPrivacyStatement=false)
    .title('已收集个人信息清单')
    .backgroundColor('#F1F3F5')

  }

}