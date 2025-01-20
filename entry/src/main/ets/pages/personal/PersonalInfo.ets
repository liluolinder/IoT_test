import { BusinessError } from '@ohos.base';
import { photoAccessHelper } from '@kit.MediaLibraryKit';

@ComponentV2
export  struct PersonalInfo {

  @Local isShow:boolean=false;
  @Local userName:string='暂未登录';



  @Builder
  PersonalLogInBuildSheet()
  {
    Column()
    {
      Text('没做完')
    }
  }

  build() {

    Row(){

      Image($r('app.media.startIcon'))
        .padding('16')
        .height('100%')

      Text(this.userName)
        .font({size:16,weight:FontWeight.Normal})

    }.backgroundColor(Color.White)
    .height(90)
    .width('90%')
    .borderRadius('20')
    .onClick(()=>this.isShow=true)
    .bindSheet($$this.isShow,             //$$引用表示，isShow变量值与组件bindSheetLoginInBuilder状态一致
      this.PersonalLogInBuildSheet(),
      {
        height:300,
        title: { title: "快捷登录", subtitle: "Quick to log in" },
        preferType:SheetType.BOTTOM,
      })
    .clickEffect({level:ClickEffectLevel.LIGHT})
  }
}